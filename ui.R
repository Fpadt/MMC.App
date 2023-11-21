library(shinythemes)

shinyUI(fluidPage(theme = shinytheme("flatly"),

                  titlePanel("JADS - C2 Enexis"),
                  h3('M/M/c Queueing Model'),
                  h6('forked from Thomas Roh'),
                  br(),
                  sidebarPanel(
                    numericInput('arr.rate', label = 'EV arrival rate (EV/hr)', value = 40),
                    numericInput('serv.rate',label = 'Charging rate (EV/hr)'  , value = 50),
                    sliderInput('servers',   label = 'Charging Stations',min = 1, max = 100,
                                value = as.vector(c(1,25)),ticks = T,width = '500px'),
                    #    selectInput('time.units','Time Units',c('Seconds','Minutes','Hours','Days')),
                    strong('Explanation:'),
                    p(' '),
                    p('This tool analyzes charging stations with poisson EV-arrival rates and exponential charging times.'),
                    p('Change the Arrival Rate (average EVs/hour) and the Charging Rate (average EVs charged/hour).'),
                    p('Adjust the range of number of charging stations to see comparative service levels for the following metrics:'),
                    p(' '),
                    p('- mean number of EVs waiting (Lq)'),
                    p('- mean EV waiting time (Wq)'),
                    p('- mean number of EVs in Charging Hub (Ls)'),
                    p('- mean EV total time in Charging Hub (Ws)'),
                    p('- mean Charging Station utilization')

                  ),

                  mainPanel(
                    img(src='BrainStorm.png', align = "right", height=75),

                    tabsetPanel(
                      tabPanel('Lq', plotOutput('Lqplot')),
                      tabPanel('Wq', plotOutput('Wqplot')),
                      tabPanel('Ls', plotOutput('Lsplot') , width = 800, height = 600),
                      tabPanel('Ws', plotOutput('Wsplot')),
                      tabPanel('Utilization',plotOutput('Uplot'))

                    ),
                    p('\n'),
                    p('\n'),
                    img(src='truck1.gif', align = "center", height=100),
                    img(src='truck1.gif', align = "center", height=100),
                    img(src='truck1.gif', align = "center", height=100),
                    img(src='truck1.gif', align = "right", height=100),

                  )
))
