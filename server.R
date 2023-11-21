library(ggplot2)
library(queueing)

shinyServer(
  function(input, output) {

    results <- reactive({

      servers      <- seq(input$servers[1], input$servers[2], 1)
      arrival.rate <- input$arr.rate/60
      service.rate <- input$serv.rate/60

      if(arrival.rate >= service.rate*servers[1])
        stop('The service rate * number of servers must be greater than the arrival rate.')

      inputs.MMC <- lapply(servers, function(x) NewInput.MMC(arrival.rate, service.rate, x))
      models     <- lapply(inputs.MMC, QueueingModel)
      results    <- data.frame(
        Servers     = as.integer(servers),
        L           = sapply(models, L),
        Lq          = sapply(models, Lq),
        W           = sapply(models, W),
        Wq          = sapply(models, Wq),
        Utilization = sapply(models, RO))
      results
    })


    output$Lsplot <- renderPlot({

      ggplot(results(), aes(x = Servers, y = L)) +
        geom_smooth(method = loess,stat="identity",size = 2,color = '#B6D300') +
        labs(x = 'Number of Servers',y = 'mean # of EVs in Charging Hub')

    })

    output$Lqplot <- renderPlot({

      ggplot(results(),aes(x = Servers, y = Lq)) +
        geom_smooth(method = loess,stat="identity",size = 2,color = '#D8006F') +
        labs(x = 'Number of Charging Stations',y = 'mean # of EVs waiting')

    })

    output$Wsplot <- renderPlot({

      ggplot(results(),aes(x = Servers,y = W)) +
        geom_smooth(method = loess,stat="identity",size = 2,color = '#B6D300') +
        labs(x = 'Number of Charging Stations',y = paste('mean Time in Charging Hub (minutes)',sep=''))

    })

    output$Wqplot <- renderPlot({

      ggplot(results(),aes(x = Servers,y = Wq)) +
        geom_smooth(method = loess,stat="identity",size = 2,color = '#D8006F') +
        labs(x = 'Number of Charging Stations',y = paste('mean Waiting Time (minutes)',sep=''))

    })

    output$Uplot <- renderPlot({

      #results <- results()
      ggplot(results(),aes(x = Servers,y = Utilization)) +
        geom_smooth(
          method = loess, stat="identity",
          size = 2, color = '#FF0000') +
        labs(x = 'Number of Charging Stations', y = 'mean Charging Station Utilization')

    })

  }
)
