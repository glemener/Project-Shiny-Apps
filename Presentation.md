Introducing myApps!
========================================================
author: Guillaume Le Mener
date: June 20th 2015

Introduction
========================================================

In data science, we spent a lot of time to analyze dataset.

- looking at the summary of some variables of interest
- creating boxplot of 2 variables to understand quantiles and outliers
- looking at some clustering technics to see the relationships of variables

But, how can we automate this to be as simple as 2 clicks?

Welcome to MyApps!
========================================================

Imagine you would like to switches between 2 datasets and always compute `summary()` of variables:


```r
summary(mtcars$mpg)
```

```
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  10.40   15.42   19.20   20.09   22.80   33.90 
```

```r
summary(iris$Sepal.Length)
```

```
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  4.300   5.100   5.800   5.843   6.400   7.900 
```

Now, you can easily with myApps available [here](https://glemener.shinyapps.io/App-1). And much more!

How does it work?
========================================================
![alt text](main_screen.png)
***
myApps is very easy to use:
- select your dataset so the variables are automatically updated
- if you select 1 variable, its `summary()` is printed
- if you select 2, the `summary()` is updated and a `boxplot()` is displayed!
- if you select more than two variables, `summary()` is updated ;-)

What doest it look like?
========================================================
![alt text](results.png)
***
The screen on the left shows:
- a `summary()` output for the selected variables
- a blox plot for the first 2 variables. x and y labels are dynamically updated!
- a cluster based on K-means. You can change the number of clusters on the left. Nice!

Remenber to click on the button for the cluster to update and plot!

What's next?
========================================================
myApps is completely dynamic so you can easily add more dataset.
- ui.R code to change is here:  

```
radioButtons("dataset", label="Select the dataset:", choices=c("Cars","Diamonds","Iris")),
```  

-server.R code to change is here:  
```
       datasetInput <- reactive({ switch(input$dataset,
                       "Cars" = mtcars,
                       "Diamonds" = diamonds,
                       "Iris"=iris) })
```
