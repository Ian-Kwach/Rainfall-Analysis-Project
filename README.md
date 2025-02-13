Rainfall Analysis Project
Overview
This project analyzes the maximum daily rainfall in Seletar, Singapore from January 2000 to April 2024. The analysis includes data post-processing, exploratory data analysis, and inferential statistics to understand the patterns and distribution of maximum daily rainfall at Seletar weather station.

Project Structure
CVE2112.docx: The report detailing the analysis of maximum daily rainfall.
CVE2112.R: The R script used for data processing, analysis, and visualization.
Installation
To run the R script, you need to have R and RStudio installed on your machine. You can download R from CRAN and RStudio from RStudio.

Setup
Clone this repository to your local machine:
sh

sh
Copy code
cd Rainfall-Analysis-Project
Open the CVE2112.R script in RStudio.
Usage
Run the R script CVE2112.R in RStudio.
The script will process the rainfall data, perform exploratory data analysis, and generate various plots and statistical summaries.
The results will be displayed in the RStudio console and plotted in the plot viewer.
Analysis
Data Post-Processing
The initial dataset comprises daily rainfall totals. The script extracts the highest daily rainfall total for each month to focus on extreme rainfall events.

Exploratory Data Analysis (EDA)
EDA includes:

Summary statistics to highlight year-to-year variability.
Box plots to show the distribution patterns of rainfall for the wettest and driest months.
Violin plots to compare the distribution of daily rainfall totals.
Histograms with KDE to visualize the distribution of rainfall amounts.
Time series plots to depict trends and seasonal patterns.
Inferential Statistics
The data is fitted to log-normal and gamma distributions to model the rainfall data. Goodness-of-fit tests such as Kolmogorov-Smirnov, Cramer-von Mises, and Anderson-Darling tests are performed to evaluate the fit.

Results
The analysis provides insights into the variability and central tendency of maximum daily rainfall. The gamma distribution is found to fit the data better, indicating a higher occurrence of moderate to high rainfall events.

Conclusion
Understanding the patterns and distributions of maximum daily rainfall is crucial for urban planning and designing resilient infrastructure. The findings underline the importance of considering variability and distribution characteristics in planning and disaster management strategies.

References
Kristo C., Rahardjo H., & Satyanaga A. (2017). Effect of variations in rainfall intensity on slope stability in Singapore.
Liong S. Y., & He S. (2010). Raingauge-based rainfall nowcasting with artificial neural network.
Rahardjo H., Nistor M. M., Gofar N., Satyanaga A., Xiaosheng Q., & Chui Yee S. I. (2020). Spatial distribution variation and trend of five-day antecedent rainfall in Singapore.
Heng H. H., & Hii C. P. (2011). A review on probable maximum precipitation (PMP) estimation in Malaysia.
