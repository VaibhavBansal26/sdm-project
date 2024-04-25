# #
# # This is a Shiny web application. You can run the application by clicking
# # the 'Run App' button above.
# #
# # Find out more about building applications with Shiny here:
# #
# #    https://shiny.posit.co/
# #
# 
library(shiny)
library(shinydashboard)
library(DT)
library(DBI)
library(RSQLite)
library(ggplot2)
library(shinythemes)
library(shinyjs)
library(shinycssloaders)
library(lubridate)
library(shinyFeedback)
library(dplyr)
library(dbplyr)
library(plotly) 
library(shinycssloaders)


# Connect to your SQLite database
sqldb_connection <- dbConnect(RSQLite::SQLite(), 'data/customer_sales_new_db.db')

# Define the UI
library(shinydashboard)


content_html <- HTML('
  <div class="research-paper">
    <h1 class="title">Customer Segmentation and Sales Analysis with Product Recommendation</h1>
    <h2 class="authors">Atul Sharma, Mounika Reddy Katikam Venkata, Vaibhav Bansal, Devendra Rana</h2>
    
    <h2>Abstract</h2>
    <p>This proposal aims to implement a comprehensive approach to understanding and exploiting customer and sales data to improve business outcomes through targeted customer interaction and enhanced product recommendation. By grouping our customers based on both their spending habits and personal demographics, we aim to personalize our marketing efforts and utilize the power of customer feedback by analysing reviews to measure the popularity of our products to understand the emotions behind customer preferences. Our goal is to predict shopping patterns and purchase likelihood. We are implementing algorithms like k-means clustering, Random Forest, and Naïve Bayes for customer segmentation, and sentiment analysis algorithms to interpret the emotions in customer reviews, and purchasing behaviour for tailoring promotional offers. This intelligent blend of data science and marketing strategy is the cornerstone of our approach to driving sales and enhancing the customer experience. (#1)</p>
    
    <!-- Introduction -->
    <h2>Introduction</h2>
    <p>Current practices in customer segmentation and product placement struggle with scattered data</p>
    
    <h2>Literature Survey</h2>
    <p>Current practices in customer segmentation and product placement struggle with scattered data, basic demographic reliance, and manual analysis, leading to inefficiencies. The market segmentation model supports dynamic pricing strategies to maximize profits by adjusting prices based on consumer purchasing behaviour and price sensitivity [1]. Personalization in marketing is usually not as fine-tuned as it could be, often reactive rather than proactive, with product recommendations that may not resonate on an individual level [2]. In physical stores, product placements tend to be static and are not optimized based on real-time data analysis. Additionally, traditional methods of sentiment analysis may not fully capture the intricate sentiments expressed in customer feedback. The sentiment analysis methods when applied on  Amazon reviews, highlighted effective negation handling and sentiment scoring, but has implicated challenges with implicit sentiments and neutral expressions[3]. Our proposed approach intend to address these limitations by utilizing advanced algorithms for deeper and more predictive customer insights, leading to more effective personalization and dynamic product positioning both online and in physical settings. (#2)

    Our approach integrates advanced machine learning algorithms such as k-means clustering, Random Forest, and Naïve Bayes to develop a dynamic and detailed picture of customer segments, surpassing traditional demographic-based segmentation. The hybrid classifier KNN, Stochastic gradient emerges as the best performer with an accuracy of 92.42%, demonstrating that combining algorithms effectively minimizes error and improves predictive capability [4].Random Forest and Naive Bayes are generally used for customer segmentation, enhancing promotional strategies with exceptional accuracy in classifying multi-class data, despite the complexity of feature selection and model parameters. [5]. By combining these with sentiment analysis, we can understand not just the what but also the why behind customer behaviours and preferences, diving deeper into the emotional factors driving their purchasing decisions. Customer segmentation methods in e-commerce, emphasize the shift from mass marketing to personalized strategies using methods like k-means clustering [6]. Many research have proven that product categories moderate the impact of reviews and motivating factors on sales [7]. Also, the fact that negative reviews significantly impact sales more than positive ones due to the negativity bias [8]. A recent research investigated various clustering algorithms when applied on the UK retail sector using the Recency, Frequency, Monetary (RFM) framework has provided insights on selecting effective clustering methods for customer data analysis to improve marketing strategies but does not address scalability for large datasets. [9].The application of K-means clustering for segmenting e-commerce customers based on their purchase behaviours, is significantly used for enhancing marketing strategies. This has proven useful when targeting behavioural segmentation to improve customer engagement and retention. However, the study¯s reliance on K-means clustering could be a limitation, as it may not adequately handle noisy data or outliers [10].  A research  has identified reasons for customer churn such as poor quality experiences, lack of understanding, and budget constraints, while advocating for ongoing monitoring of customer trends to sustain customer loyalty [11]. E-commerce relies on personalization to combat information overload. Customer segmentation is key, using various data sources and methods. This targeted approach enhances accuracy and effectiveness by focusing on customer behaviour data [12].This holistic view enables us to make more accurate predictions about future buying patterns and to personalize marketing and product recommendations. (#3)
  
    Our advanced approach to customer segmentation and product placement will benefit various stakeholders. Businesses will experience improved customer engagement and sales efficiency, while marketing teams receive better targeting tools, and product development is enhanced by data-driven insights. Customers will enjoy a more personalized shopping experience. Success will be measured by increased sales, customer satisfaction, and loyalty. Key metrics such as user studies, A/B testing, and sentiment analysis will guide ongoing refinements for continuous improvement. (#4, #5)
    
    Implementing a sophisticated customer segmentation and product placement strategy carries risks such as potential data privacy violations, a heavy reliance on complex technology, sizable initial costs, and possible resistance from within the organization. Integrating advanced analytics can be a complex process that disrupts existing workflows. However, the potential rewards justify the venture, with the promise of increased revenue from improved targeting accuracy, enhanced customer loyalty due to more personalized experiences, operational savings from data-driven inventory management, and a competitive edge in the marketplace. (#6)  </p>
    
    <!-- Methodology -->
    <h2>Methodology</h2>
    <p>Our approach integrates advanced machine learning algorithms such as k-means clustering...</p>
    
    <!-- Results -->
    <h2>Results</h2>
    <p>The hybrid classifier KNN, Stochastic gradient emerges as the best performer with an accuracy of 92.42%...</p>
    
    <!-- Discussion -->
    <h2>Discussion</h2>
    <p>Customer segmentation methods in e-commerce, emphasize the shift from mass marketing to personalized strategies...</p>
    
    <!-- Conclusion -->
    <h2>Conclusion</h2>
    <p>Our advanced approach to customer segmentation and product placement will benefit various stakeholders...</p>
    
    <!-- References -->
    <h2>References</h2>
    <ol>
      <li>Tavor T., Gonen L. D., & Spiegel, U. (2023). Customer Segmentation as a Revenue Generator for Profit Purposes...</li>
      <li>Patankar, Nikhil & Dixit, Soham & Bhamare, Akshay & Darpel, Ashutosh & Raina, Ritik. (2021). Customer Segmentation Using Machine Learning. 10.3233/APC210200.</li>
      <li>Fang, X., Zhan, J. Sentiment analysis using product review data. Journal of Big Data 2, 5 (2015). <a href="https://doi.org/10.1186/s40537-015-0015-233">https://doi.org/10.1186/s40537-015-0015-233</a></li>
      <li>Tavor T., Gonen L. D., & Spiegel, U. (2023). Customer Segmentation as a Revenue Generator for Profit Purposes. Mathematics, 11(21), 4425. <a href="https://doi.org/10.3390/math11214425">https://doi.org/10.3390/math11214425</a></li>
      <li>Chaubey, G., Gavhane, P.R., Bisen, D. et al. Customer purchasing behavior prediction using machine learning classification techniques. J Ambient Intell Human Comput 14, 16133–16157 (2023). <a href="https://doi.org/10.1007/s12652-022-03837-6">https://doi.org/10.1007/s12652-022-03837-6</a></li>
      <li>Puspa, Sofia & Puspitasari, Fani & Riyono, Joko & Pujiastuti, Christina & Bijlsma, David & Leo, Joseph. (2023). Customer Segmentation Analysis Using Random Forest & Naïve Bayes Method In The Case of Multi-Class Classification at PT. XYZ. Mathline : Jurnal Matematika dan Pendidikan Matematika. 8. 1359-1372. <a href="10.31943/mathline.v8i4.532">10.31943/mathline.v8i4.532</a></li>
      <li>Alves Gomes, M., Meisen, T. A review on customer segmentation methods for personalized customer targeting in e-commerce use cases. Inf Syst E-Bus Manage 21, 527–570 (2023). <a href="https://doi.org/10.1007/s10257-023-00640-4">https://doi.org/10.1007/s10257-023-00640-4</a></li>
      <li>Kunlin Li, Yuhan Chen, Liyi Zhang, Exploring the influence of online reviews and motivating factors on sales: A meta-analytic study and the moderating role of product category, Journal of Retailing and Consumer Services, Volume 55, 2020, 102107, ISSN 0969-6989, <a href="https://doi.org/10.1016/j.jretconser.2020.102107">https://doi.org/10.1016/j.jretconser.2020.102107</a></li>
      <li>Cui, Geng & Lui, Hon-Kwong & Guo, Xiaoning. (2012). The Effect of Online Consumer Reviews on New Product Sales. International Journal of Electronic Commerce. 17. 39-58. <a href="10.2307/41739503">10.2307/41739503</a></li>
      <li>John, J. M., Shobayo, O., & Ogunleye, B. (2023). An Exploration of Clustering Algorithms for Customer Segmentation in the UK Retail Market. Analytics, 2(4), 809–823. <a href="https://doi.org/10.3390/analytics2040042">https://doi.org/10.3390/analytics2040042</a></li>
      <li>Tabianan K, Velu S, Ravi V. K-Means Clustering Approach for Intelligent Customer Segmentation Using Customer Purchase Behavior Data. Sustainability. 2022; 14(12):7243. <a href="https://doi.org/10.3390/su14127243">https://doi.org/10.3390/su14127243</a></li>
      <li>Ranjan, A., & Srivastava, S. (2022). Customer segmentation using machine learning: A literature review. AIP Conference Proceedings, 2481(1), 020036. <a href="https://doi.org/10.1063/5.0103946">https://doi.org/10.1063/5.0103946</a></li>
      <li>Nurma Sari, Juni & Nugroho, Lukito & Ferdiana, Ridi & Santosa, Paulus. (2016). Review on Customer Segmentation Technique on Ecommerce. Advanced Science Letters. 22. 3018-3022. <a href="10.1166/asl.2016.7985">10.1166/asl.2016.7985</a></li>
    </ol>
  </div>
')

ui <- dashboardPage(
  skin = "purple",
  dashboardHeader(title = "SDM Project"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home", tabName = "home", icon = icon("home")),
      menuItem("Data Preparation", tabName = "dataprep", icon = icon("tasks")),
      menuItem("Data View", tabName = "dataview", icon = icon("table")),
      menuItem("Analysis", tabName = "charts", icon = icon("bar-chart")),
      menuItem("Charts", tabName = "charts", icon = icon("bar-chart")),
      menuItem("Roadmap", tabName = "roadmap", icon = icon("map")),
      menuItem("About", tabName = "about", icon = icon("info-circle"))
    )
  ),
  dashboardBody(
    tags$head(
      tags$style(HTML("
        body {
          font-family: 'Arial', sans-serif;
          background-color: #f4f4f4;
        }
        .content-wrapper {
          background-color: #f4f4f4;
        }
        .box {
          border-radius: 5px;
          box-shadow: 0 0 20px rgba(0,0,0,0.1);
          background-color: #ffffff;
          padding: 20px;
          margin-bottom: 20px;
        }
        .ibox {
          border-radius: 5px;
          box-shadow: 0 0 20px rgba(0,0,0,0.1);
          background-color: #ffffff;
          padding: 20px;
          margin-bottom: 20px;
          display:flex;
          align-items:center;
          width:100%;
        }
        .innerbox {
          margin-left:15px;
        }
        h2, h3 {
          color: #333;
        }
        p {
          color: #666;
          line-height: 1.5;
        }
        a {
          color: #337ab7;
          text-decoration: none;
        }
        a:hover {
          text-decoration: underline;
        }
        tab-content {
          overflow-y: auto;
        }
        .main-sidebar, .main-header {
          position: fixed;
          z-index: 998;
        }
        .main-header {
          width:100%;
          z-index: 999;
        }
        .content-wrapper {
          margin-top: 50px;
          margin-left: 230px;
        }
        .research-paper {
          padding: 20px;
          font-family: 'Times New Roman', Times, serif;
        }
        .research-paper .title {
          text-align: center;
          font-size: 24px;
          font-weight: bold;
        }
        .research-paper .authors {
          text-align: center;
          font-size: 20px;
          font-weight: normal;
        }
        .research-paper h2 {
          margin-top: 24px;
          font-size: 20px;
        }
        .research-paper p {
          text-align: justify;
          margin-top: 12px;
        }
        .research-paper ol {
          list-style-type: decimal;
        }
        .research-paper ul li {
          margin-top: 8px;
          margin-bottom: 8px;
        }
        .scrollable-table-container {
          overflow-x: auto;
          width: 100%;
        }
        .roadmap_content {
        font-family: 'Times New Roman', Times, serif;
        }
      "))
    ),
    tabItems(
      tabItem(tabName = "home",
              content_html,
              downloadButton("downloadPDF", "Download PDF")
      ),
      tabItem(tabName = "dataprep",
              h2("Data Preparation"),
              verbatimTextOutput("dataSummary"),
              dataTableOutput("dataHead")
      ),
      tabItem(tabName = "dataview",
              h2("Dataset View"),
              br(),
              downloadButton("downloadData", "Download Data"),
              br(),
              br(),
              br(),
              div(class = "scrollable-table-container",
                  DT::dataTableOutput("dataView") %>% shinycssloaders::withSpinner())
      ),
      tabItem(tabName = "charts",
              h2("Charts"),
              sliderInput("bins", "Number of bins:", min = 1, max = 50, value = 30),
              plotOutput("histPlot")
      ),
      tabItem(tabName = "roadmap",
              div(class="box",
                  h2("Project Roadmap"),
                  div(class="roadmap_content",
                      tags$h3("1. Data Preparation"),
                      tags$p("Initial data cleaning and preprocessing to ensure data quality and usability."),
                      tags$h3("2. Exploring the Content of Variables"),
                      tags$ul(
                        tags$li("2.1 Countries: Analyze sales or interactions by country."),
                        tags$li("2.2 Customers and Products:",
                                tags$ul(
                                  tags$li("2.2.1 Cancelling Orders: Examine patterns or trends in order cancellations."),
                                  tags$li("2.2.2 StockCode: Explore the variety and frequency of stock codes used."),
                                  tags$li("2.2.3 Basket Price: Analyze the total price of baskets over time or per customer.")
                                )
                        )
                      ),
                      tags$h3("3. Insight on Product Categories"),
                      tags$ul(
                        tags$li("3.1 Product Description: Explore the text data to understand product features."),
                        tags$li("3.2 Defining Product Categories:",
                                tags$ul(
                                  tags$li("3.2.1 Data Encoding: Convert text data into a format suitable for analysis."),
                                  tags$li("3.2.2 Clusters of Products: Use clustering algorithms to find product groupings."),
                                  tags$li("3.2.3 Characterizing the Content of Clusters: Describe and analyze these clusters.")
                                )
                        )
                      ),
                      tags$h3("4. Customer Categories"),
                      tags$ul(
                        tags$li("4.1 Formatting Data:",
                                tags$ul(
                                  tags$li("4.1.1 Grouping Products: Organize products into logical groups."),
                                  tags$li("4.1.2 Time Splitting of the Dataset: Segment data into time-based subsets."),
                                  tags$li("4.1.3 Grouping Orders: Aggregate orders for analysis.")
                                )
                        ),
                        tags$li("4.2 Creating Customer Categories:",
                                tags$ul(
                                  tags$li("4.2.1 Data Encoding: Transform customer data for machine learning."),
                                  tags$li("4.2.2 Creating Categories: Define and create distinct customer categories.")
                                )
                        )
                      ),
                      tags$h3("5. Classifying Customers"),
                      tags$p("Deploy various machine learning models to classify customers based on their behaviors and attributes."),
                      tags$ul(
                        tags$li("5.1 SVC (Support Vector Machine Classifier):",
                                tags$ul(
                                  tags$li("5.1.1 Confusion Matrix: Evaluate model accuracy."),
                                  tags$li("5.1.2 Learning Curves: Assess model performance over time.")
                                )
                        ),
                        tags$li("5.2 Logistic Regression"),
                        tags$li("5.3 k-Nearest Neighbors"),
                        tags$li("5.4 Decision Tree"),
                        tags$li("5.5 Random Forest"),
                        tags$li("5.6 AdaBoost"),
                        tags$li("5.7 Gradient Boosting Classifier"),
                        tags$li("5.8 Find Best: Evaluate and select the best performing model.")
                      ),
                      tags$h3("6. Testing the Predictions"),
                      tags$p("Validate the model predictions with a separate test set or real-world data."),
                      tags$h3("7. Conclusion"),
                      tags$p("Summarize findings, implications, and potential business impacts.")
                  ),
                  div(class='gantt',
                      h2('Gantt Chart'),
                      plotlyOutput("ganttChart")
                  )
              )
      ),
      tabItem(tabName = "about",
              div(class="box",
                  h2("About the Team"),
                  div(class="ibox",
                      img(src="https://media.licdn.com/dms/image/C5603AQHQHWQDUq4fbQ/profile-displayphoto-shrink_100_100/0/1562869615080?e=1719446400&v=beta&t=OQOZEqsz1ULYWpMl0Dv_u_Nv-jsXftXf4Sndjk23UVw", class="profile-img"),
                      div(class="innerbox",
                          h3("Vaibhav Bansal"),
                          p("Vaibhav is a dedicated team member specializing in data analysis. He consistently brings innovative solutions to complex problems."),
                          p("Connect with Vaibhav on ", a(href="https://www.linkedin.com/in/vaibhavbansal-profile", "LinkedIn"), ".")
                      )
                  ),
                  div(class="ibox",
                      img(src="https://media.licdn.com/dms/image/C4E03AQHcRo--Ur7qRw/profile-displayphoto-shrink_100_100/0/1597762603455?e=1719446400&v=beta&t=4X8bh4wI834QycpPZXVyuOXAWUjrP5d2B10A1kgIGgg", class="profile-img"),
                      div(class="innerbox",
                          h3("Devendra Rana"),
                          p("Devendra, our CEO, has a robust background in strategic planning and business development."),
                          p("Learn more about Devendra's professional journey on ", a(href="https://www.linkedin.com/in/devendra-rana-4541021b5/", "LinkedIn"), ".")
                      )
                  ),
                  div(class="ibox",
                      # img(src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJhvWpQrh3nIxmjLBQSyH5uu7OKpprR2b4-g&usqp=CAU", class="profile-img"),
                      div(class="innerbox",
                          h3("Mounika"),
                          p("Mounika, as CMO, excels in marketing strategies and customer engagement, driving the team towards market success."),
                          p("View Mounika's career achievements on ", a(href="https://www.linkedin.com/in/mounika", "LinkedIn"), ".")
                      )
                  ),
                  div(class="ibox",
                      img(src="https://media.licdn.com/dms/image/D4D03AQEFAOpkmnDzdA/profile-displayphoto-shrink_100_100/0/1698843844757?e=1719446400&v=beta&t=iOLZz9aG75QbrQJdNL84GsDUJ3U38mQuvDUazp9a9nQ", class="profile-img"),
                      div(class="innerbox",
                          h3("Atul Sharma"),
                          p("Atul, the CTO, is an expert in technology management and product development with a knack for innovation."),
                          p("Follow Atul on ", a(href="https://www.linkedin.com/in/atul-sharma-b7941919b/", "LinkedIn"), " to see his latest tech advancements.")
                      )
                  )
              ),
              div(class="box",
                  h2("About Our Professor"),
                  p("Professor Jianzhen Liu  is an esteemed figure in data science with extensive experience in both academia and industry."),
                  p("He is known for his methodical approach to teaching and his commitment to student success."),
                  p("Discover more about Professor Jianzhen Liu work on ", a(href="https://www.linkedin.com/in/professor-xyz", "LinkedIn"), ".")
              )
      )
    )
  )
)

# Server logic
server <- function(input, output) { 
  output$text_content <- renderUI({
    div(style="white-space: pre-wrap;", content_text)
  })
  query <- "SELECT * FROM review_added_data"
  df_initial <- dbGetQuery(sqldb_connection, query)
  
  if ("InvoiceDate" %in% names(df_initial) && !inherits(df_initial$InvoiceDate, "POSIXct")) {
    df_initial$InvoiceDate <- ymd_hms(df_initial$InvoiceDate)
  }
  
  # Debug and check data type consistency
  column_types <- sapply(df_initial, function(x) class(x)[1])
  null_values_nb <- sapply(df_initial, function(x) sum(is.na(x)))
  null_values_perc <- sapply(df_initial, function(x) 100 * mean(is.na(x)))
  
  # Create a summary table
  tab_info <- data.frame(
    'Column Type' = column_types,
    'Null Values (Nb)' = null_values_nb,
    'Null Values (%)' = null_values_perc,
    check.names = FALSE, stringsAsFactors = FALSE
  )
  
  # Ensure row names match column names for clarity
  row.names(tab_info) <- names(df_initial)
  
  # Output data summary
  output$dataSummary <- renderPrint({
    cat("Dataframe dimensions:", paste(dim(df_initial), collapse = " x "), "\n")
    print(tab_info)
  })
  
  # Output the head of the data
  output$dataHead <- renderDataTable({
    head(df_initial)
  })
  
  # Full data view
  output$dataView <- renderDataTable({
    df_initial
  })
  
  # Data View
  output$dataView <- DT::renderDataTable({
    query <- sprintf("SELECT * FROM review_added_data")
    data <- dbGetQuery(sqldb_connection, query)
    DT::datatable(data)
  })
  
  # Charts (Histogram)
  output$histPlot <- renderPlot({
    data <- rnorm(100)
    bins <- seq(min(data), max(data), length.out = input$bins + 1)
    hist(data, breaks = bins, col = 'lightblue', border = 'white')
  })
  
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("data-", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      query <- "SELECT * FROM review_added_data"
      data <- dbGetQuery(sqldb_connection, query)
      write.csv(data, file, row.names = FALSE)
    }
  )
  output$ganttChart <- renderPlotly({
    tasks <- data.frame(
      Name = c("Vaibhav", "Devendra", "Atul", "Mounika"),
      Task = c("Data Preparation", "Modeling", "Testing", "Deployment"),
      Start = as.Date(c("2024-01-01", "2024-02-01", "2024-03-01", "2024-04-01")),
      Finish = as.Date(c("2024-01-31", "2024-02-28", "2024-03-31", "2024-04-30")),
      stringsAsFactors = FALSE
    )
    
    fig <- plot_ly()
    for(i in 1:nrow(tasks)) {
      fig <- fig %>% add_trace(
        x = c(tasks$Start[i], tasks$Finish[i]), y = c(tasks$Name[i], tasks$Name[i]),
        mode = 'lines',
        line = list(width = 20),
        name = tasks$Task[i]
      )
    }
    fig
  })
}

# Run the application
shinyApp(ui, server)


