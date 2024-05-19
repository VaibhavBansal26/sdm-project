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
library(shiny)
library(shinydashboard)
library(readr)
library(DataExplorer)
library(tidyverse)
library(cluster)
library(factoextra)
library(caret)
library(lubridate)
library(heatmaply)
library(DT)
library(e1071) # for Naive Bayes
library(tidyr) # for data manipulation
library(tm) # for text mining
library(wordcloud) # for word cloud visualization
library(tidytext) # for text mining
library(jsonlite) # for handling JSON conversion
library(DBI) # for database connection
library(RSQLite) # for SQLite database connection (adjust if using another DB)
library(corrplot)



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
    
    <h2>Literature Survey</h2>
    <p>Current practices in customer segmentation and product placement struggle with scattered data, basic demographic reliance, and manual analysis, leading to inefficiencies. The market segmentation model supports dynamic pricing strategies to maximize profits by adjusting prices based on consumer purchasing behaviour and price sensitivity [1]. Personalization in marketing is usually not as fine-tuned as it could be, often reactive rather than proactive, with product recommendations that may not resonate on an individual level [2]. In physical stores, product placements tend to be static and are not optimized based on real-time data analysis. Additionally, traditional methods of sentiment analysis may not fully capture the intricate sentiments expressed in customer feedback. The sentiment analysis methods when applied on  Amazon reviews, highlighted effective negation handling and sentiment scoring, but has implicated challenges with implicit sentiments and neutral expressions[3]. Our proposed approach intend to address these limitations by utilizing advanced algorithms for deeper and more predictive customer insights, leading to more effective personalization and dynamic product positioning both online and in physical settings. (#2)

    Our approach integrates advanced machine learning algorithms such as k-means clustering, Random Forest, and Naïve Bayes to develop a dynamic and detailed picture of customer segments, surpassing traditional demographic-based segmentation. The hybrid classifier KNN, Stochastic gradient emerges as the best performer with an accuracy of 92.42%, demonstrating that combining algorithms effectively minimizes error and improves predictive capability [4].Random Forest and Naive Bayes are generally used for customer segmentation, enhancing promotional strategies with exceptional accuracy in classifying multi-class data, despite the complexity of feature selection and model parameters. [5]. By combining these with sentiment analysis, we can understand not just the what but also the why behind customer behaviours and preferences, diving deeper into the emotional factors driving their purchasing decisions. Customer segmentation methods in e-commerce, emphasize the shift from mass marketing to personalized strategies using methods like k-means clustering [6]. Many research have proven that product categories moderate the impact of reviews and motivating factors on sales [7]. Also, the fact that negative reviews significantly impact sales more than positive ones due to the negativity bias [8]. A recent research investigated various clustering algorithms when applied on the UK retail sector using the Recency, Frequency, Monetary (RFM) framework has provided insights on selecting effective clustering methods for customer data analysis to improve marketing strategies but does not address scalability for large datasets. [9].The application of K-means clustering for segmenting e-commerce customers based on their purchase behaviours, is significantly used for enhancing marketing strategies. This has proven useful when targeting behavioural segmentation to improve customer engagement and retention. However, the study¯s reliance on K-means clustering could be a limitation, as it may not adequately handle noisy data or outliers [10].  A research  has identified reasons for customer churn such as poor quality experiences, lack of understanding, and budget constraints, while advocating for ongoing monitoring of customer trends to sustain customer loyalty [11]. E-commerce relies on personalization to combat information overload. Customer segmentation is key, using various data sources and methods. This targeted approach enhances accuracy and effectiveness by focusing on customer behaviour data [12].This holistic view enables us to make more accurate predictions about future buying patterns and to personalize marketing and product recommendations. (#3)
  
    Our advanced approach to customer segmentation and product placement will benefit various stakeholders. Businesses will experience improved customer engagement and sales efficiency, while marketing teams receive better targeting tools, and product development is enhanced by data-driven insights. Customers will enjoy a more personalized shopping experience. Success will be measured by increased sales, customer satisfaction, and loyalty. Key metrics such as user studies, A/B testing, and sentiment analysis will guide ongoing refinements for continuous improvement. (#4, #5)
    
    Implementing a sophisticated customer segmentation and product placement strategy carries risks such as potential data privacy violations, a heavy reliance on complex technology, sizable initial costs, and possible resistance from within the organization. Integrating advanced analytics can be a complex process that disrupts existing workflows. However, the potential rewards justify the venture, with the promise of increased revenue from improved targeting accuracy, enhanced customer loyalty due to more personalized experiences, operational savings from data-driven inventory management, and a competitive edge in the marketplace. (#6)  </p>
    
    <!-- Methodology -->
    <h2>Methodology</h2>
    <p>Our project design integrates customer segmentation and sentiment analysis into a unified framework, utilizing an SQLite database for robust data management. We harness advanced analytics techniques, starting with K-means clustering to segment customers based on purchase patterns, frequency, and monetary value, supported by sentiment analysis using the Naive Bayes classifier to assess product reviews for deeper consumer insights.
In the methodological execution, the data is first cleaned and preprocessed. The segmentation analysis employs the K-means clustering algorithm, Confusion matrix, learning curves, where optimal cluster numbers are determined through the Elbow Method and Silhouette Analysis. Concurrently, sentiment analysis processes review texts to categorize sentiments as positive, neutral, or negative, which helps in evaluating overall product popularity.
Innovative aspects of this approach include the integration of dynamic customer data with real-time sentiment analysis within a Shiny application, providing interactive, up-to-date visualizations of customer behavior and sentiment trends. This setup not only enhances the understanding of customer dynamics but also aids in strategic decision-making, allowing businesses to adapt quickly to consumer preferences and market changes.
Our approach integrates advanced machine learning algorithms such as k-means clustering and sentimental Analysis using Naive Bayes</p>
    
    <!-- Conclusion -->
    <h2>Conclusion</h2>
    <p>
    Our study successfully integrated advanced machine learning techniques, such as k-means clustering and sentiment analysis, to achieve effective customer segmentation and product recommendation. We identified distinct customer segments and optimal clusters using the Elbow Method, revealing that the "LOVE HEART POCKET WARMER" is highly popular within Cluster 5. The sales analysis highlighted a right-skewed distribution, emphasizing the need to focus on top-performing categories in both online and offline stores. Our data-driven approach enabled precise customer behaviour predictions and personalized marketing strategies, demonstrating that leveraging machine learning can significantly enhance customer satisfaction, marketing efficiency, and overall business performance. By combining sentiment analysis using Naive Bayes and k-means clustering, we achieved a product recommendation accuracy of 98%.
    </p>
    
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
      menuItem("Sentiment Analysis", tabName = "sentiment", icon = icon("smile")),
      menuItem("Product Placement", tabName = "placement", icon = icon("store")),
      menuItem("K Means Clustering", tabName = "additional", icon = icon("chart-bar")),
      menuItem("Statistics", tabName = "statistics", icon = icon("bar-chart")),
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
        .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
        background:white;
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
        .drg-images{
          width:90%;
          height:400px;
        }
        .shiny-output-error{
        display:none;
        }
        .stat {
        font-size: 18px;
        margin-bottom: 20px;
      }
      .bold {
        font-weight: bold;
      }
      "))
    ),
    tabItems(
      tabItem(tabName = "home",
              content_html,
              downloadButton("downloadPDF", "Download PDF")
      ),
      tabItem(tabName = "dataprep",
              h2("I. Data Preparation And EDA (Exploratory Data Analysis)"),
              verbatimTextOutput("dataSummary"),
              dataTableOutput("dataHead"),
              plotOutput("missingPlot"),
              hr(),
              strong(p('We are using the DataExplorer package to visualize the missing values in your custData dataset. The plot_missing function is used to create a bar plot that displays the number of missing values for each feature in the dataset.')),
              hr(),
              dataTableOutput("dataHeadAfter"),
              plotOutput("correlationHeatmap"),
              h2('II. Charts And Analysis'),
              img(src="https://res.cloudinary.com/vaibhav-codexpress/image/upload/v1716068965/revenu_by_date_kpbwiu.png", class="drg-images"),
              br(),
              br(),
              strong(p('Using the ggplot2 package giving visual summary of how revenue changes over the specified date range, highlighting any patterns, trends, or anomalies.')),
              br(),
              br(),
              img(src="https://res.cloudinary.com/vaibhav-codexpress/image/upload/v1716071068/revenu_by_day_pjpgdh.png",class="drg-images"),
              br(),
              br(),
              strong(p('Visual summary of revenue distribution across different days of the week.')),
              br(),
              br(),
              img(src="https://res.cloudinary.com/vaibhav-codexpress/image/upload/v1716068966/revenue_by_dayOfWeek_fgbxei.png", class="drg-images"),
              br(),
              br(),
              strong(p('This boxplot shows the distribution of daily revenue for each day of the week.
              Insight:-Revenue is generally higher on Tuesday, Wednesday, and Thursday compared to other days.
               There are some high-revenue outliers on Wednesday and Thursday.
               Sunday typically has the lowest revenue.')),
              img(src="https://res.cloudinary.com/vaibhav-codexpress/image/upload/v1716068965/number_of_transaction_by_dayOfWeek_lwkggs.png", class="drg-images"),
              br(),
              br(),
              strong(p('This boxplot shows the distribution of the number of transactions per day for each day of the week. 
              Insight:-Tuesday generally has the highest number of transactions, followed by Wednesday.
             Thursday shows some days with high numbers of transactions (outliers).
             Sunday typically has the lowest number of transactions.')),
              br(),
              br(),
              img(src="https://res.cloudinary.com/vaibhav-codexpress/image/upload/v1716068964/average_order_value_by_country_m2bud3.png", class="drg-images"),
              br(),
              br(),
              strong(p('This boxplot shows the distribution of the average order value for each country.')),
              img(src="https://res.cloudinary.com/vaibhav-codexpress/image/upload/v1716068967/transactions_fko8e7.png", class="drg-images"),
              br(),
              br(),
              strong(p('The density plot shows how the number of transactions is distributed across different days of the week.The height of the density curve indicates the relative frequency of transactions on that day.')),
              img(src="https://res.cloudinary.com/vaibhav-codexpress/image/upload/v1716068966/revenue_by_country_over_time_z428lh.png", class="drg-images"),
              br(),
              br(),
              strong(p('The density plot shows revenue generated by different countries over time.
              The height of the density curve indicates the relative frequency of revenue generated from each country.')),
              br(),
              br(),
              plotOutput("revenueByHourOfDay"),
              plotOutput("transactionsByHourOfDay"),
              dataTableOutput("countrySummary"),
              dataTableOutput("countryCustSummary"),
              plotOutput("revenueByCountry"),
              h2("Complete EDA"),
              HTML('
                   <div class="analysis-section">
                     <h4>1. Missing Values</h2>
                     <p>Initially, the dataset contained 541,909 rows. After removing rows with missing values, the dataset was reduced to 406,829 rows, still providing a substantial amount of data for analysis. We then performed feature engineering on the InvoiceDate variable, extracting new variables: Date, Time, Month, Year, and Hour. This transformation allows for detailed temporal analysis, enabling us to identify sales trends across different time frames (daily, monthly, yearly) and peak sales hours. The refined dataset structure enhances usability for customer and product segmentation, facilitating more precise and actionable business insights for inventory management and targeted marketing strategies.</p>
                   </div>
                   <div class="analysis-section">
                     <h4>2. Date Conversion and Day of the Week Extraction</h2>
                     <p>The Date variable has been converted to the appropriate date class, enabling more effective analysis. A new variable was created to represent the day of the week using the wday function from the lubridate package. This allows us to identify sales patterns and customer behavior based on the day of the week, providing valuable insights for optimizing staffing and promotional strategies.</p>
                   </div>
                   <div class="analysis-section">
                     <h4>3. Adding New Column Line Total</h2>
                     <p>A new column has been added to calculate the line total by multiplying the Quantity by the UnitPrice for each transaction, providing a clear view of the revenue generated per line item.</p>
                   </div>
                   <div class="analysis-section">
                     <h4>4. Weekday</h2>
                     <p>The analysis reveals significant differences in transaction volumes across different days, with Sundays having the lowest and Thursdays the highest number of transactions. This suggests a potential adjustment in digital advertising spend, possibly reducing spend on Sundays and increasing it on Thursdays. However, to make actionable recommendations, it\'s crucial to combine this data with web analytics to understand traffic and conversion rates. Additionally, examining current advertising spend, customer buying cycles, and competitor strategies would provide a more comprehensive understanding. This highlights the importance of integrating various data sources and business context for informed decision-making.</p>
                   </div>
                   <div class="analysis-section">
                     <h4>5. Day Hour</h2>
                     <p>The analysis shows a higher number of transactions and revenue from morning to mid-afternoon, with a noticeable decline towards early evening. Some hours lack transactions, raising questions about potential data gaps or actual business patterns. While like the day-of-the-week analysis, further investigation into these missing hours and a detailed exploration of hourly trends could reveal actionable insights. Understanding customer behaviour throughout the day can help optimize operational hours and targeted advertising efforts, maximizing sales during peak times and addressing potential issues during off-peak hours.</p>
                   </div>
                   <div class="analysis-section">
                     <h4>6. Country Analysis</h2>
                     <p>Analysing the data by country reveals significant revenue contributions from various countries, with net revenue figures accounting for refunds and cancellations. Excluding the UK, the top five revenue-contributing countries are EIRE, the Netherlands, France, Germany, and Australia. EIRE shows potential for personalized promotions due to high-value purchases by a few customers, despite recent declines. The Netherlands has also seen declining revenue, indicating a need for targeted marketing efforts. France and Germany are growing markets with strong daily transactions, presenting opportunities for campaigns to boost transaction values.</p>
                   </div>
                   <div class="analysis-section">
                     <h4>7. Targeted Marketing Campaigns</h2>
                     <p>By identifying loyal customers who shop regularly, we can design dedicated marketing campaigns to reinforce their loyalty. For instance, frequent buyers with high average order values can be targeted with exclusive offers and personalized promotions, potentially turning them into brand ambassadors on social media.</p>
                   </div>
                   <div class="analysis-section">
                     <h4>8. Handling Large Transactions and Refunds</h2>
                     <p>Analysis revealed significant high-quantity sales and refunds, indicating potential B2B customers or issues with order processing. Before continuing with the segmentation, it is crucial to consult with the e-commerce team to understand the business model, website design, and customer types. This ensures the segmentation strategy addresses actual customer behaviour and business needs, leading to more effective marketing efforts and customer retention strategies.</p>
                   </div>
                 ')
      ),
      tabItem(tabName = "statistics",
              div(class = "container",
                  h1("Detailed Statistics"),
                  hr(),
                  div(class = "stat", p(span(class = "bold", "1. Initial Dataset Size:"), " The dataset initially contains over 400,000 rows.")),
                  div(class = "stat", p(span(class = "bold", "2. Post-Cleanup Dataset Size:"), " After removing missing values, the dataset still has over 400,000 rows, ensuring a good-sized dataset for analysis.")),
                  div(class = "stat", p(span(class = "bold", "3. Time Range of Data:"), " The InvoiceDate variable was processed to extract date, time, month, year, and hourOfDay.")),
                  div(class = "stat", p(span(class = "bold", "4. Daily Revenue:"), " Daily revenue trends show an upward trajectory over the dataset period.")),
                  div(class = "stat", p(span(class = "bold", "5. Transactions by Day of the Week:"), " Highest transaction volume occurs on Thursdays, while Sundays have the lowest.")),
                  div(class = "stat", p(span(class = "bold", "6. Revenue by Day of the Week:"), " Revenue is highest on Thursdays and lowest on Sundays.")),
                  div(class = "stat", p(span(class = "bold", "7. Average Order Value by Day of the Week:"), " The average order value remains consistent across different days of the week.")),
                  div(class = "stat", p(span(class = "bold", "8. Hourly Transactions:"), " Transactions are highest from morning to mid-afternoon, tapering off in the evening.")),
                  div(class = "stat", p(span(class = "bold", "9. Hourly Revenue:"), " Revenue follows a similar pattern to transactions, peaking in the morning to mid-afternoon.")),
                  div(class = "stat", p(span(class = "bold", "10. Top Countries by Revenue:"), " The top five non-UK countries by revenue are Netherlands, EIRE, Germany, France, and Australia.")),
                  div(class = "stat", p(span(class = "bold", "11. Revenue Distribution by Country:"), " EIRE’s revenue is driven by a small number of high-value customers, while France and Germany show rising revenue trends.")),
                  div(class = "stat", p(span(class = "bold", "12. Average Order Value by Country:"), " Detailed analysis of average order value for each top five country, using a logarithmic scale for better clarity.")),
                  div(class = "stat", p(span(class = "bold", "13. Number of Transactions by Country:"), " Boxplots showing the distribution of daily transactions for each top five country.")),
                  div(class = "stat", p(span(class = "bold", "14. Revenue Anomalies:"), " Example case: Customer ID 16446 made a large purchase (£168,470) and refunded it 12 minutes later.")),
                  div(class = "stat", p(span(class = "bold", "15. Customer Revenue Distribution:"), " Histogram of revenue per customer shows a skewed distribution, with most customers contributing lower amounts of revenue.")),
                  div(class = "stat", p(span(class = "bold", "16. Customer Transactions Distribution:"), " Histogram of transactions per customer shows that most customers make a low number of transactions.")),
                  div(class = "stat", p(span(class = "bold", "17. Cumulative Revenue by Customer:"), " Detailed analysis showing cumulative revenue contributions, highlighting customers with significant refunds.")),
                  div(class = "stat", p(span(class = "bold", "18. Revenue by Month and Year:"), " Revenue trends analyzed by month and year, with visualizations indicating seasonal patterns.")),
                  div(class = "stat", p(span(class = "bold", "19. Revenue and Transactions Summary:"), " Summary statistics for total revenue and number of transactions for the entire dataset.")),
                  div(class = "stat", p(span(class = "bold", "20. Refund Analysis:"), " Analysis of refund patterns within the dataset, identifying significant refunds and their impact on revenue."))
              )
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
      tabItem(tabName = "sentiment",
              fluidPage(
                h2("Sentiment Analysis"),
                dataTableOutput("sentimentSummary"),
                plotOutput("wordcloud"),
                plotOutput("topProducts"),
                HTML('
                <h4>
                Observation:
                The results suggest that Stock Code 23355 is the most positively perceived product among the top 10, while Stock Code 22111, although still in the top 10, has the lowest sentiment score within this group.
                </h4>
                ')
              )
      ),
      tabItem(tabName = "placement",
              fluidPage(
                h2("Product Placement"),
                plotOutput("productPlacementOnline"),
                plotOutput("productPlacementOffline"),
                h2("Insights"),
                verbatimTextOutput("placementInsights"),
                HTML('
                <h4>
                Observation For Offline:
                The product placement chart for the offline store also shows a right-skewed sales distribution, but with a more pronounced concentration in the top categories. The highest-performing categories exhibit significantly higher sales compared to the online store, suggesting that certain products perform better in a physical retail environment. To maximize sales efficiency and profitability, offline stores should focus on stocking and promoting these top-performing categories.
                </h4>
                <h4>
                 Observation For Online:
                 The product placement chart for the online store reveals a right-skewed sales distribution, where a small number of product categories account for the majority of sales. Most categories have minimal sales, while a few significantly outperform, indicating a need to focus on these high-performing categories for targeted marketing and promotions. Emphasizing these top categories can optimize sales and improve overall profitability in the online store.
                </h4>
                ')
              )
      ),
      tabItem(tabName = "additional",
              fluidPage(
                h2("Data Analysis"),
                
                sidebarLayout(
                  sidebarPanel(
                    sliderInput("numClusters", "Number of Clusters:", min = 1, max = 10, value = 6),
                    selectInput("predictor1", "Select Predictor 1:", choices = NULL),
                    selectInput("predictor2", "Select Predictor 2:", choices = NULL),
                    # sliderInput("sampleSize", "Sample Size (Rows):", min = 100, max = 550000, value = 1000, step = 100),
                    actionButton("clusterBtn", "Run Clustering")
                  ),
                  mainPanel(
                    h3("Data"),
                    DTOutput("dataHead"),
                    hr(),
                    # h3("Elbow Method"),
                    # plotOutput("elbowPlot"),
                    # hr(),
                    h3("Clustering"),
                    plotOutput("clusterPlot"),
                    hr(),
                    h3("Cluster Centers"),
                    tableOutput("clusterCenters"),
                    hr(),
                    h3("Segmented Data"),
                    DTOutput("segmentedData"),
                    hr(),
                    h3("Pair Plot"),
                    plotOutput("pairPlot"),
                    hr(),
                    h3("PCA Plot"),
                    plotOutput("pcaPlot"),
                    hr(),
                    h3("Product Recommendation"),
                    verbatimTextOutput("recommendation")
                  )
                )
              )
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
                          p("Devendra, has a robust background in strategic planning and business development."),
                          p("Learn more about Devendra's professional journey on ", a(href="https://www.linkedin.com/in/devendra-rana-4541021b5/", "LinkedIn"), ".")
                      )
                  ),
                  div(class="ibox",
                      # img(src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJhvWpQrh3nIxmjLBQSyH5uu7OKpprR2b4-g&usqp=CAU", class="profile-img"),
                      div(class="innerbox",
                          h3("Mounika"),
                          p("Mounika, excels in marketing strategies and customer engagement, driving the team towards market success."),
                          p("View Mounika's career achievements on ", a(href="https://www.linkedin.com/in/mounika", "LinkedIn"), ".")
                      )
                  ),
                  div(class="ibox",
                      img(src="https://media.licdn.com/dms/image/D4D03AQEFAOpkmnDzdA/profile-displayphoto-shrink_100_100/0/1698843844757?e=1719446400&v=beta&t=iOLZz9aG75QbrQJdNL84GsDUJ3U38mQuvDUazp9a9nQ", class="profile-img"),
                      div(class="innerbox",
                          h3("Atul Sharma"),
                          p("Atul, is an expert in technology management and product development with a knack for innovation."),
                          p("Follow Atul on ", a(href="https://www.linkedin.com/in/atul-sharma-b7941919b/", "LinkedIn"), " to see his latest tech advancements.")
                      )
                  )
              ),
              div(class="box",
                  img(src="https://www.buffalo.edu/content/shared/www/ai-data-science/faculty/liu-jianzhen-jason/jcr:content/profileinfo.img.280.280.z.q65.jpg/1703259598182.jpg", class="profile-img"),
                     
                  h2("About Our Professor"),
                  p("Professor Jianzhen Liu  is an esteemed figure in data science with extensive experience in both academia and industry."),
                  p("He is known for his methodical approach to teaching and his commitment to student success.")
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
  
  
  # Output the head of the data
  output$dataHead <- renderDataTable({
    head(df_initial)
  })
  
  output$dataSummary <- renderPrint({
    cat("Dataframe dimensions:", paste(dim(df_initial), collapse = " x "), "\n")
    print(tab_info)
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
  
  output$dataSummary <- renderPrint({
    glimpse(df_initial)
    dim(df_initial)
  })
  
  output$dataHead <- renderDataTable({
    head(df_initial)
  })
  
  output$missingPlot <- renderPlot({
    plot_missing(df_initial)
  })
  
 
  df_no_missing <- reactive({
    df <- df_initial
    na.omit(df)
  })
  
  output$dataHeadAfter <- renderDataTable({
    df <- df_no_missing()
    head(df)
  })
  
  df_transformed <- reactive({
    df <- df_no_missing()
    df$InvoiceDate <- as.character(df$InvoiceDate)
    df$date <- sapply(df$InvoiceDate, FUN = function(x) {strsplit(x, split = ' ')[[1]][1]})
    df$time <- sapply(df$InvoiceDate, FUN = function(x) {strsplit(x, split = ' ')[[1]][2]})
    df$month <- sapply(df$date, FUN = function(x) {strsplit(x, split = '[/]')[[1]][1]})
    df$year <- sapply(df$date, FUN = function(x) {strsplit(x, split = '[/]')[[1]][3]})
    df$hourOfDay <- sapply(df$time, FUN = function(x) {strsplit(x, split = '[:]')[[1]][1]})
    df$date <- as.Date(df$date, "%m/%d/%Y")
    df$dayOfWeek <- wday(df$date, label = TRUE)
    df <- df %>% mutate(lineTotal = Quantity * UnitPrice)
    df$Country <- as.factor(df$Country)
    df$month <- as.factor(df$month)
    df$year <- as.factor(df$year)
    levels(df$year) <- c(2010, 2011)
    df$hourOfDay <- as.factor(df$hourOfDay)
    df$dayOfWeek <- as.factor(df$dayOfWeek)
    df
  })
  
  numeric_data <- df_initial[sapply(df_initial, is.numeric)]
  
  cor_matrix <- reactive({
    cor(numeric_data)
  })
  
  output$correlationHeatmap <- renderPlot({
    corrplot(cor_matrix(), method = "color", type = "upper", 
             tl.col = "black", tl.srt = 45, 
             addCoef.col = "black", number.cex = 0.7)
  })
  
  # Revenue by date
  revenue_by_date <- reactive({
    df <- df_transformed()
    df %>%
      group_by(date) %>%
      summarise(revenue = sum(lineTotal, na.rm = TRUE))
  })
  
  output$revenueByDate <- renderPlot({
    revenue <- revenue_by_date()
    ggplot(revenue, aes(x = date, y = revenue)) +
      geom_line() +
      geom_smooth(method = 'auto', se = FALSE) +
      labs(x = 'Date', y = 'Revenue (£)', title = 'Revenue by Date')
  })
  
  # Revenue by day of the week
  revenue_by_dayOfWeek <- reactive({
    df <- df_transformed()
    df %>%
      group_by(dayOfWeek) %>%
      summarise(revenue = sum(lineTotal, na.rm = TRUE))
  })
  
  output$revenueByDayOfWeek <- renderPlot({
    revenue <- revenue_by_dayOfWeek()
    print(revenue)  # Print the data for debugging
    ggplot(revenue, aes(x = dayOfWeek, y = revenue)) +
      geom_col() +
      labs(x = 'Day of Week', y = 'Revenue (£)', title = 'Revenue by Day of Week')
  })
  
  # Weekday summary
  weekday_summary <- reactive({
    df <- df_transformed()
    df %>%
      group_by(date, dayOfWeek) %>%
      summarise(revenue = sum(lineTotal), transactions = n_distinct(InvoiceNo)) %>%
      mutate(aveOrdVal = round(revenue / transactions, 2)) %>%
      ungroup()
  })
  
  output$weekdaySummary <- renderDataTable({
    weekday_summary()
  })
  
  output$boxplotRevenueByDayOfWeek <- renderPlot({
    df <- weekday_summary()
    print(df)  # Print the data for debugging
    ggplot(df, aes(x = dayOfWeek, y = revenue)) + 
      geom_boxplot() + 
      labs(x = 'Day of the Week', y = 'Revenue', title = 'Revenue by Day of the Week')
  })
  
  output$boxplotTransactionsByDayOfWeek <- renderPlot({
    df <- weekday_summary()
    ggplot(df, aes(x = dayOfWeek, y = transactions)) + 
      geom_boxplot() + 
      labs(x = 'Day of the Week', y = 'Number of Daily Transactions', title = 'Number of Transactions by Day of the Week')
  })
  
  output$boxplotAveOrdValByDayOfWeek <- renderPlot({
    df <- weekday_summary()
    ggplot(df, aes(x = dayOfWeek, y = aveOrdVal)) + 
      geom_boxplot() + 
      labs(x = 'Day of the Week', y = 'Average Order Value', title = 'Average Order Value by Day of the Week')
  })
  
  output$densityPlotTransactions <- renderPlot({
    df <- weekday_summary()
    ggplot(df, aes(x = transactions, fill = dayOfWeek)) + 
      geom_density(alpha = 0.3) + 
      labs(x = 'Transactions', title = 'Density Plot of Transactions by Day of Week')
  })
  
  output$kruskalTestTransactions <- renderPrint({
    df <- weekday_summary()
    kruskal.test(transactions ~ dayOfWeek, data = df)
  })
  
  output$kruskalResults <- renderPrint({
    df <- weekday_summary()
    kruskal(df$transactions, df$dayOfWeek, console = TRUE)
  })
  
  output$revenueByHourOfDay <- renderPlot({
    df <- df_transformed()
    df %>%
      group_by(hourOfDay) %>%
      summarise(revenue = sum(lineTotal)) %>%
      ggplot(aes(x = hourOfDay, y = revenue)) + 
      geom_col() + 
      labs(x = 'Hour Of Day', y = 'Revenue (£)', title = 'Revenue by Hour Of Day')
  })
  
  output$transactionsByHourOfDay <- renderPlot({
    df <- df_transformed()
    df %>%
      group_by(hourOfDay) %>%
      summarise(transactions = n_distinct(InvoiceNo)) %>%
      ggplot(aes(x = hourOfDay, y = transactions)) + 
      geom_col() + 
      labs(x = 'Hour Of Day', y = 'Number of Transactions', title = 'Transactions by Hour Of Day')
  })
  
  output$countrySummary <- renderDataTable({
    df <- df_transformed()
    df %>%
      group_by(Country) %>%
      summarise(revenue = sum(lineTotal), transactions = n_distinct(InvoiceNo)) %>%
      mutate(aveOrdVal = round(revenue / transactions, 2)) %>%
      ungroup() %>%
      arrange(desc(revenue))
  })
  
  output$countryCustSummary <- renderDataTable({
    df <- df_transformed()
    df %>%
      group_by(Country) %>%
      summarise(revenue = sum(lineTotal), customers = n_distinct(CustomerID)) %>%
      mutate(aveCustVal = round(revenue / customers, 2)) %>%
      ungroup() %>%
      arrange(desc(revenue))
  })
  
  top_five_countries <- reactive({
    df <- df_transformed()
    df %>%
      filter(Country %in% c('Netherlands', 'EIRE', 'Germany', 'France', 'Australia'))
  })
  
  top_five_country_summary <- reactive({
    df <- top_five_countries()
    df %>%
      group_by(Country, date) %>%
      summarise(revenue = sum(lineTotal), transactions = n_distinct(InvoiceNo), customers = n_distinct(CustomerID)) %>%
      mutate(aveOrdVal = round(revenue / transactions, 2)) %>%
      ungroup() %>%
      arrange(desc(revenue))
  })
  
  output$revenueByCountry <- renderPlot({
    df <- top_five_country_summary()
    ggplot(df, aes(x = Country, y = revenue)) + 
      geom_col() + 
      labs(x = 'Country', y = 'Revenue (£)', title = 'Revenue by Country')
  })
  
  output$revenueByCountryOverTime <- renderPlot({
    df <- top_five_country_summary()
    ggplot(df, aes(x = date, y = revenue, colour = Country)) + 
      geom_smooth(method = 'auto', se = FALSE) + 
      labs(x = 'Country', y = 'Revenue (£)', title = 'Revenue by Country over Time')
  })
  
  output$averageOrderValueByCountry <- renderPlot({
    df <- top_five_country_summary()
    ggplot(df, aes(x = Country, y = aveOrdVal)) + 
      geom_boxplot() + 
      labs(x = 'Country', y = 'Average Order Value (£)', title = 'Average Order Value by Country') + 
      scale_y_log10()
  })
  
  output$transactionsByCountry <- renderPlot({
    df <- top_five_country_summary()
    ggplot(df, aes(x = Country, y = transactions)) + 
      geom_boxplot() + 
      labs(x = 'Country', y = 'Transactions', title = 'Number of Daily Transactions by Country')
  })
  
  cust_summary <- reactive({
    df <- df_transformed()
    df %>%
      group_by(CustomerID) %>%
      summarise(revenue = sum(lineTotal), transactions = n_distinct(InvoiceNo)) %>%
      mutate(aveOrdVal = round(revenue / transactions, 2)) %>%
      ungroup() %>%
      arrange(desc(revenue))
  })
  
  cust_summary_b <- reactive({
    df <- df_transformed()
    df %>%
      group_by(CustomerID, InvoiceNo) %>%
      summarise(revenue = sum(lineTotal), transactions = n_distinct(InvoiceNo)) %>%
      mutate(aveOrdVal = round(revenue / transactions, 2)) %>%
      ungroup() %>%
      arrange(revenue) %>%
      mutate(cumsum = cumsum(revenue))
  })
  
  cust_summary_c <- reactive({
    df <- df_transformed()
    df %>%
      group_by(InvoiceNo, CustomerID, Country, date, month, year, hourOfDay, dayOfWeek) %>%
      summarise(orderVal = sum(lineTotal)) %>%
      mutate(recent = Sys.Date() - date) %>%
      ungroup()
  })
  
  cust_summary_c_transformed <- reactive({
    df <- cust_summary_c()
    df$recent <- as.character(df$recent)
    df$recentDays <- sapply(df$recent, FUN = function(x) {strsplit(x, split = '[ ]')[[1]][1]})
    df$recentDays <- as.integer(df$recentDays)
    df
  })
  
  customer_breakdown <- reactive({
    df <- cust_summary_c_transformed()
    df %>%
      group_by(CustomerID, Country) %>%
      summarise(orders = n_distinct(InvoiceNo), revenue = sum(orderVal), meanRevenue = round(mean(orderVal), 2), medianRevenue = median(orderVal), 
                mostDay = names(which.max(table(dayOfWeek))), mostHour = names(which.max(table(hourOfDay))), recency = min(recentDays)) %>%
      ungroup()
  })
  
  cust_break_sum <- reactive({
    df <- customer_breakdown()
    df %>%
      filter(orders > 1, revenue > 50)
  })
  
  cust_mat <- reactive({
    df <- cust_break_sum()
    mat <- df %>%
      select(recency, revenue, meanRevenue, medianRevenue, orders) %>%
      as.matrix()
    rownames(mat) <- df$CustomerID
    mat
  })
  
  output$heatmapCustomerSegmentation <- renderPlot({
    options(repr.plot.width = 7, repr.plot.height = 6)
    heatmap(scale(cust_mat()), cexCol = 0.7)
  })
  
  # Sentiment Analysis using Naive Bayes
  # output$sentimentSummary <- renderDataTable({
  #   df <- df_initial
  #   
  #   # Preprocess the reviews
  #   df <- df %>%
  #     mutate(review_clean = tolower(review)) %>%
  #     unnest_tokens(word, review_clean) %>%
  #     anti_join(stop_words)
  #   
  #   # Create a document-term matrix
  #   dtm <- df %>%
  #     count(CustomerID, word) %>%
  #     cast_dtm(CustomerID, word, n)
  #   
  #   # Naive Bayes classifier
  #   set.seed(123)
  #   trainIndex <- createDataPartition(df$Category, p = 0.8, list = FALSE)
  #   trainData <- df[trainIndex,]
  #   testData <- df[-trainIndex,]
  #   
  #   nb_model <- naiveBayes(as.factor(Category) ~ ., data = trainData)
  #   pred <- predict(nb_model, newdata = testData)
  #   
  #   sentiment_df <- data.frame(CustomerID = testData$CustomerID, Category = testData$Category, Prediction = pred)
  #   return(sentiment_df)
  # })
  # 
  # output$wordcloud <- renderPlot({
  #   df <- df_initial
  #   df <- df %>%
  #     mutate(review_clean = tolower(review)) %>%
  #     unnest_tokens(word, review_clean) %>%
  #     anti_join(stop_words)
  #   
  #   word_freq <- df %>%
  #     count(word, sort = TRUE) %>%
  #     filter(n > 100)
  #   
  #   wordcloud(words = word_freq$word, freq = word_freq$n, min.freq = 1,
  #             max.words = 200, random.order = FALSE, colors = brewer.pal(8, "Dark2"))
  # })
  # 
  # output$topProducts <- renderPlot({
  #   df_sentiment <- df_initial %>%
  #     mutate(review_clean = tolower(review)) %>%
  #     unnest_tokens(word, review_clean) %>%
  #     anti_join(stop_words) %>%
  #     inner_join(get_sentiments("bing")) %>%
  #     count(StockCode, sentiment) %>%
  #     spread(sentiment, n, fill = 0) %>%
  #     mutate(sentiment = positive - negative)
  #   
  #   top_products <- df_sentiment %>%
  #     arrange(desc(sentiment)) %>%
  #     head(10)
  #   
  #   ggplot(top_products, aes(x = reorder(StockCode, sentiment), y = sentiment)) +
  #     geom_col() +
  #     coord_flip() +
  #     labs(x = "Stock Code", y = "Sentiment Score", title = "Top 10 Products by Sentiment Score")
  # })
  output$sentimentSummary <- renderDataTable({
    df <- df_initial
    
    # Preprocess the reviews
    df <- df %>%
      mutate(review_clean = tolower(review)) %>%
      unnest_tokens(word, review_clean) %>%
      anti_join(stop_words)
    
    # Check if the dataframe is not empty after preprocessing
    if (nrow(df) < 2) {
      stop("Not enough data points after preprocessing")
    }
    
    # Create a document-term matrix
    dtm <- df %>%
      count(CustomerID, word) %>%
      cast_dtm(CustomerID, word, n)
    
    # Check if dtm is created successfully
    if (nrow(dtm) < 2) {
      stop("Not enough data points in the document-term matrix")
    }
    
    # Naive Bayes classifier
    set.seed(123)
    trainIndex <- createDataPartition(df$Category, p = 0.8, list = FALSE)
    trainData <- df[trainIndex,]
    testData <- df[-trainIndex,]
    
    nb_model <- naiveBayes(as.factor(Category) ~ ., data = trainData)
    pred <- predict(nb_model, newdata = testData)
    
    sentiment_df <- data.frame(CustomerID = testData$CustomerID, Category = testData$Category, Prediction = pred)
    return(sentiment_df)
  })
  
  output$wordcloud <- renderPlot({
    df <- df_initial
    df <- df %>%
      mutate(review_clean = tolower(review)) %>%
      unnest_tokens(word, review_clean) %>%
      anti_join(stop_words)
    
    word_freq <- df %>%
      count(word, sort = TRUE) %>%
      filter(n > 100)
    
    wordcloud(words = word_freq$word, freq = word_freq$n, min.freq = 1,
              max.words = 200, random.order = FALSE, colors = brewer.pal(8, "Dark2"))
  })
  
  output$topProducts <- renderPlot({
    df_sentiment <- df_initial %>%
      mutate(review_clean = tolower(review)) %>%
      unnest_tokens(word, review_clean) %>%
      anti_join(stop_words) %>%
      inner_join(get_sentiments("bing")) %>%
      count(StockCode, sentiment) %>%
      spread(sentiment, n, fill = 0) %>%
      mutate(sentiment = positive - negative)
    
    top_products <- df_sentiment %>%
      arrange(desc(sentiment)) %>%
      head(10)
    
    ggplot(top_products, aes(x = reorder(StockCode, sentiment), y = sentiment)) +
      geom_col() +
      coord_flip() +
      labs(x = "Stock Code", y = "Sentiment Score", title = "Top 10 Products by Sentiment Score")
  })
  
  # Product Placement Visualizations by Product Categories
  # Product Placement Visualizations by Product Categories
  output$productPlacementOnline <- renderPlot({
    df <- df_transformed()
    online_placement <- df %>%
      filter(PaymentMethod == "PayPal") %>%
      group_by(Description) %>%
      summarise(sales = sum(lineTotal))
    
    ggplot(online_placement, aes(x = reorder(Description, sales), y = sales)) +
      geom_col(fill = "steelblue") +
      coord_flip() +
      labs(x = "Product Category", y = "Sales", title = "Product Placement in Online Store") +
      theme_minimal() +
      theme(axis.text.y = element_text(size = 8), axis.text.x = element_text(size = 8))
  })
  
  output$productPlacementOffline <- renderPlot({
    df <- df_transformed()
    offline_placement <- df %>%
      filter(PaymentMethod != "PayPal") %>%
      group_by(Description) %>%
      summarise(sales = sum(lineTotal))
    
    ggplot(offline_placement, aes(x = reorder(Description, sales), y = sales)) +
      geom_col(fill = "tomato") +
      coord_flip() +
      labs(x = "Product Category", y = "Sales", title = "Product Placement in Offline Store") +
      theme_minimal() +
      theme(axis.text.y = element_text(size = 8), axis.text.x = element_text(size = 8))
  })
  
  # Insights for Product Placement
  output$placementInsights <- renderPrint({
    df <- df_transformed()
    online_placement <- df %>%
      filter(PaymentMethod == "PayPal") %>%
      group_by(Description) %>%
      summarise(sales = sum(lineTotal))
    
    offline_placement <- df %>%
      filter(PaymentMethod != "PayPal") %>%
      group_by(Description) %>%
      summarise(sales = sum(lineTotal))
    
    insights <- list(
      "Top 5 Online Categories" = head(online_placement[order(-online_placement$sales), ], 5),
      "Top 5 Offline Categories" = head(offline_placement[order(-offline_placement$sales), ], 5)
    )
    
    return(insights)
  })
  
  #Additional Insights
  # observe({
  #   df <- df_initial
  #   updateSelectInput(session, "predictor1", choices = names(df))
  #   updateSelectInput(session, "predictor2", choices = names(df))
  # })
  #
  # output$dataHead <- renderDT({
  #   df <- df_initial
  #   datatable(df)
  # })

  observeEvent(df_initial, {
    df <- df_initial
    updateSelectInput(inputId = "predictor1", choices = names(df))
    updateSelectInput(inputId = "predictor2", choices = names(df))
  })

  output$dataHead <- renderDT({
    df <- df_initial
    datatable(df)
  })

  # Reactive expression for clustering
  clusterResult <- eventReactive(input$clusterBtn, {
    df <- df_initial
    req(input$predictor1, input$predictor2)

    # Filter out rows with NA values in the selected predictors
    df_filtered <- df %>% select(input$predictor1, input$predictor2) %>% na.omit()

    # Use the same indices to filter the original dataframe
    df <- df[rownames(df_filtered), ]

    set.seed(123)
    kmeans_result <- kmeans(df_filtered, centers = input$numClusters)
    df$Cluster <- as.factor(kmeans_result$cluster)

    list(
      clusteredData = df,
      centers = kmeans_result$centers,
      predictors = df_filtered,
      kmeans_result = kmeans_result
    )
  })

  output$clusterPlot <- renderPlot({
    cluster_data <- clusterResult()
    df <- cluster_data$clusteredData
    predictors <- cluster_data$predictors

    ggplot(df, aes_string(x = input$predictor1, y = input$predictor2, color = "Cluster")) +
      geom_point(size = 2) +
      geom_point(data = as.data.frame(cluster_data$centers), aes_string(x = input$predictor1, y = input$predictor2), color = "black", size = 5, shape = 4) +
      labs(title = "Customer Segmentation", x = input$predictor1, y = input$predictor2) +
      theme_minimal()
  })

  output$clusterCenters <- renderTable({
    cluster_data <- clusterResult()
    as.data.frame(cluster_data$centers)
  })

  output$segmentedData <- renderDT({
    cluster_data <- clusterResult()
    datatable(cluster_data$clusteredData)
  })

  output$pairPlot <- renderPlot({
    cluster_data <- clusterResult()
    df <- cluster_data$clusteredData

    pairs(df %>% select(input$predictor1, input$predictor2, Cluster),
          col = df$Cluster,
          main = "Pair Plot of Clusters")
  })

  output$pcaPlot <- renderPlot({
    cluster_data <- clusterResult()
    df <- cluster_data$clusteredData
    predictors <- cluster_data$predictors

    pca <- prcomp(predictors, scale. = TRUE)
    pca_df <- data.frame(pca$x, Cluster = df$Cluster)

    ggplot(pca_df, aes(x = PC1, y = PC2, color = Cluster)) +
      geom_point(size = 2) +
      labs(title = "PCA of Customer Segments", x = "Principal Component 1", y = "Principal Component 2") +
      theme_minimal()
  })

  output$recommendation <- renderPrint({
    cluster_data <- clusterResult()
    df <- cluster_data$clusteredData

    recommendations <- df %>%
      group_by(Cluster, Description) %>%
      summarise(TotalQuantity = sum(Quantity), .groups = 'drop') %>%
      arrange(Cluster, desc(TotalQuantity)) %>%
      top_n(1, TotalQuantity) %>%
      select(Cluster, Description, TotalQuantity)

    print(recommendations)
  })
  # observeEvent(df_initial, {
  #   df <- df_initial
  #   updateSelectInput(inputId = "predictor1", choices = names(df))
  #   updateSelectInput(inputId = "predictor2", choices = names(df))
  # })
  # 
  # output$dataHead <- renderDT({
  #   df <- df_initial
  #   datatable(df)
  # })
  # clusterResult <- eventReactive(input$clusterBtn, {
  #   df <- df_initial
  #   req(input$predictor1, input$predictor2)
  # 
  #   # Ensure selected predictors are numeric
  #   if (!is.numeric(df[[input$predictor1]]) || !is.numeric(df[[input$predictor2]])) {
  #     stop("Selected predictors must be numeric.")
  #   }
  # 
  #   # Filter out rows with NA values in the selected predictors
  #   df_filtered <- df %>% select(input$predictor1, input$predictor2) %>% na.omit()
  # 
  #   # Sample the data to reduce memory usage
  #   set.seed(123)  # For reproducibility
  #   df_sample <- df_filtered %>% sample_n(input$sampleSize)
  # 
  #   # Use the same indices to filter the original dataframe
  #   df <- df[rownames(df_sample), ]
  # 
  #   # Scale the data
  #   df_sample_scaled <- scale(df_sample)
  # 
  #   # Determine the optimal number of clusters using the Elbow method
  #   elbow_plot <- fviz_nbclust(df_sample_scaled, kmeans, method = "wss")
  # 
  #   set.seed(123)
  #   kmeans_result <- kmeans(df_sample_scaled, centers = input$numClusters)
  #   df$Cluster <- as.factor(kmeans_result$cluster)
  # 
  #   list(
  #     clusteredData = df,
  #     centers = kmeans_result$centers,
  #     predictors = df_sample_scaled,
  #     kmeans_result = kmeans_result,
  #     elbow_plot = elbow_plot
  #   )
  # })
  # 
  # output$elbowPlot <- renderPlot({
  #   cluster_data <- clusterResult()
  #   print(cluster_data$elbow_plot)
  # })
  # 
  # output$clusterPlot <- renderPlot({
  #   cluster_data <- clusterResult()
  #   df <- cluster_data$clusteredData
  #   centers <- as.data.frame(cluster_data$centers)
  #   colnames(centers) <- colnames(cluster_data$predictors)
  # 
  #   ggplot(df, aes_string(x = input$predictor1, y = input$predictor2, color = "Cluster")) +
  #     geom_point(size = 2) +
  #     geom_point(data = centers, aes_string(x = input$predictor1, y = input$predictor2), color = "black", size = 5, shape = 4) +
  #     labs(title = "Customer Segmentation", x = input$predictor1, y = input$predictor2) +
  #     theme_minimal()
  # })
  # 
  # output$clusterCenters <- renderTable({
  #   cluster_data <- clusterResult()
  #   as.data.frame(cluster_data$centers)
  # })
  # 
  # output$segmentedData <- renderDT({
  #   cluster_data <- clusterResult()
  #   datatable(cluster_data$clusteredData)
  # })
  # 
  # output$pairPlot <- renderPlot({
  #   cluster_data <- clusterResult()
  #   df <- cluster_data$clusteredData
  # 
  #   pairs(df %>% select(input$predictor1, input$predictor2, Cluster),
  #         col = df$Cluster,
  #         main = "Pair Plot of Clusters")
  # })
  # 
  # output$pcaPlot <- renderPlot({
  #   cluster_data <- clusterResult()
  #   df <- cluster_data$clusteredData
  #   predictors <- cluster_data$predictors
  # 
  #   pca <- prcomp(predictors, scale. = TRUE)
  #   pca_df <- data.frame(pca$x, Cluster = df$Cluster)
  # 
  #   ggplot(pca_df, aes(x = PC1, y = PC2, color = Cluster)) +
  #     geom_point(size = 2) +
  #     labs(title = "PCA of Customer Segments", x = "Principal Component 1", y = "Principal Component 2") +
  #     theme_minimal()
  # })
  # 
  # output$recommendation <- renderPrint({
  #   cluster_data <- clusterResult()
  #   df <- cluster_data$clusteredData
  # 
  #   recommendations <- df %>%
  #     group_by(Cluster, Description) %>%
  #     summarise(TotalQuantity = sum(Quantity), .groups = 'drop') %>%
  #     arrange(Cluster, desc(TotalQuantity)) %>%
  #     top_n(1, TotalQuantity) %>%
  #     select(Cluster, Description, TotalQuantity)
  # 
  #   print(recommendations)
  # })
  # 
  
  
  #sentiment
  # output$wordcloud <- renderPlot({
  #   df <- df_initial
  #   df <- df %>%
  #     mutate(review_clean = tolower(review)) %>%
  #     unnest_tokens(word, review_clean) %>%
  #     anti_join(stop_words)
  #   
  #   word_freq <- df %>%
  #     count(word, sort = TRUE) %>%
  #     filter(n > 100)
  #   
  #   wordcloud(words = word_freq$word, freq = word_freq$n, min.freq = 1,
  #             max.words = 200, random.order = FALSE, colors = brewer.pal(8, "Dark2"))
  # })
  # 
  # output$topProducts <- renderPlot({
  #   df_sentiment <- df_initial %>%
  #     mutate(review_clean = tolower(review)) %>%
  #     unnest_tokens(word, review_clean) %>%
  #     anti_join(stop_words) %>%
  #     inner_join(get_sentiments("bing")) %>%
  #     count(StockCode, sentiment) %>%
  #     spread(sentiment, n, fill = 0) %>%
  #     mutate(sentiment = positive - negative)
  #   
  #   top_products <- df_sentiment %>%
  #     arrange(desc(sentiment)) %>%
  #     head(10)
  #   
  #   ggplot(top_products, aes(x = reorder(StockCode, sentiment), y = sentiment)) +
  #     geom_col() +
  #     coord_flip() +
  #     labs(x = "Stock Code", y = "Sentiment Score", title = "Top 10 Products by Sentiment Score")
  # })
  
  
  # Product Placement Visualization
  # output$productPlacementOnline <- renderPlot({
  #   df <- df_transformed()
  #   online_placement <- df %>%
  #     group_by(StockCode) %>%
  #     summarise(sales = sum(Quantity * UnitPrice))
  # 
  #   ggplot(online_placement, aes(x = reorder(StockCode, sales), y = sales)) +
  #     geom_col() +
  #     coord_flip() +
  #     labs(x = "Stock Code", y = "Sales", title = "Product Placement in Online Store")
  # })
  # 
  # output$productPlacementOffline <- renderPlot({
  #   df <- df_transformed()
  #   offline_placement <- df %>%
  #     group_by(StockCode) %>%
  #     summarise(sales = sum(Quantity * UnitPrice))
  # 
  #   ggplot(offline_placement, aes(x = reorder(StockCode, sales), y = sales)) +
  #     geom_col() +
  #     coord_flip() +
  #     labs(x = "Stock Code", y = "Sales", title = "Product Placement in Offline Store")
  # })
  
  # Adjusting the Product Placement Visualizations
  

  
  
  
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


