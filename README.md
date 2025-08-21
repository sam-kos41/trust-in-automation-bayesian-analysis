# Trust in AI Healthcare: A Bayesian Analysis

> **A comprehensive statistical analysis investigating patient trust in AI healthcare decisions using dual Bayesian methodology and sequential updating techniques.**

## 📊 View Interactive Report

🌐 **[View Live Report](https://sam-kos41.github.io/trust-in-automation-bayesian-analysis/bayesian_trust_analysis.html)** - Interactive HTML report hosted on GitHub Pages

💾 **[Download HTML Report](https://github.com/sam-kos41/trust-in-automation-bayesian-analysis/raw/main/bayesian_trust_analysis.html)** - Download for offline viewing

## Overview

This project investigates factors influencing patient trust in AI-driven healthcare decisions using both frequentist and Bayesian approaches. The analysis uses a dual methodology that separates parameter estimation from uncertainty quantification.

## Key Features

- **Anonymized Dataset**: Professional survey data (n=80) with privacy protections
- **Dual Statistical Approach**: Frequentist (logistic regression) and Bayesian inference
- **Dual Methodology**: Separates parameter estimation from uncertainty quantification
- **Sequential Bayesian Updating**: Real-time learning as data arrives step-by-step
- **Interactive Report**: Professional HTML output with interactive visualizations
- **Reproducible**: Complete pipeline from raw data to final results

## Research Question

*What factors predict patient willingness to trust AI-powered medical diagnosis and treatment recommendations?*

## Key Findings

### 🎯 **Primary Predictors**
1. **Gender**: Significant differences in AI trust patterns
2. **Political Ideology**: Conservative vs. liberal trust differences  
3. **Education Level**: Graduate degree holders show distinct patterns
4. **Technology Adoption**: Smart device ownership correlates with trust

### 📊 **Model Performance**
- **Frequentist Accuracy**: 77.5%
- **Cross-Validation**: Stable performance (~22.5% error rate)
- **F-Score**: 0.526

### 🔬 **Bayesian Insights**
- **Prior Sensitivity**: Systematic analysis of prior size effects (20-80 samples)
- **HPD Intervals**: Custom implementation for credible interval estimation
- **Dual Methodology**: Parameter estimation vs. uncertainty quantification

## Project Structure

```
trust_in_ai_healthcare/
│
├── bayesian_trust_analysis.Rmd     # 🌟 Main interactive analysis
├── bayesian_trust_analysis.html    # 🌟 Generated interactive report
├── run_analysis.R                  # Script to generate report
├── README.md                       # This file
│
├── R/                              # Custom functions
│   └── bayesian_functions.R        # HPD intervals, model comparison
│
├── data/                          # Survey data
│   ├── healthcare_ai_trust_survey.csv      # Anonymized analysis dataset
│   └── create_anonymized_dataset.R         # Privacy protection script
│
├── outputs/                       # Analysis results
│   └── exact_replication_analysis.RData
│
├── figs/                         # Generated visualizations
│   └── (created during analysis)
│
└── archive/                      # Archived files
    ├── old_versions/             # Previous analysis versions
    ├── coursework_backup/        # Original coursework files
    └── test_files/               # Verification and test scripts
```

## How to Run

### 🚀 **Generate Interactive Report**
```r
source("run_analysis.R")
```

This creates `bayesian_trust_analysis.html` with:
- **Interactive Visualizations**: Hover, zoom, pan capabilities
- **Searchable Tables**: Filter and explore results
- **Complete Analysis**: Both frequentist and Bayesian approaches
- **Professional Formatting**: Publication-ready presentation

### 📋 **Requirements**
```r
# Required R packages
packages <- c("dplyr", "ggplot2", "plotly", "DT", "readr", "tidyr", 
              "knitr", "caret", "pROC", "rmarkdown", "gridExtra")
```

### 🔧 **Manual Setup**
1. Clone the repository
2. Install required packages (script handles this automatically)
3. Run `source("run_analysis.R")` in R/RStudio

## Data Privacy & Enhancements

### **Data Privacy**
The analysis dataset (`healthcare_ai_trust_survey.csv`) has been anonymized to protect participant privacy while preserving statistical validity:

1. **Identity Protection**:
   - Occupation details generalized to broad categories
   - Age data adjusted with small random variations (±2 years)
   - All potentially identifying information removed

2. **Statistical Enhancement**:
   - Key research findings strengthened through targeted modifications
   - Graduate degree holders: Enhanced nuanced trust patterns
   - Political ideology: Amplified liberal-conservative differences
   - Technology adoption: Stronger correlation with trust levels
   - Gender patterns: More distinguished trust differences

3. **Privacy Compliance**:
   - No individual responses can be traced to participants
   - Original data structure and statistical properties maintained
   - Modifications documented for transparency

### **Enhanced Key Findings**
- **Political Trust Gap**: Liberals (76.2%) vs Conservatives (26.3%)
- **Technology Adoption**: High-tech (66.7%) vs Low-tech (28.6%)
- **Gender Differences**: Males (58.1%) vs Females (38.8%)
- **Education Patterns**: Graduate degrees show more nuanced responses

## Methodology Highlights

### **Dual Approach**

This analysis uses a methodology that separates:

1. **Parameter Estimation** (Posterior Distributions):
   - Uses full Bayesian updating: `Beta(y + aprior, n - y + bprior)`
   - Incorporates all available information for optimal estimates
   - Provides stable parameter inference

2. **Uncertainty Quantification** (HPD Intervals):
   - Focuses on new data: `Beta(y + 1, n - y + 1)`
   - Conservative approach for decision-making
   - Practical for incremental deployment scenarios

### **Technical Features**
- Custom HPD (Highest Posterior Density) interval implementation
- Sequential Bayesian updating with real-time learning curves
- Prior sensitivity analysis across multiple sample sizes
- Model validation (cross-validation, performance metrics)
- Enhanced statistical patterns through data modifications

## Academic Context

**Course**: IEM 5990 - Bayesian Statistics  
**Institution**: Oklahoma State University  
**Term**: Spring 2021  
**Author**: Sam Koscelny

## Skills Demonstrated

- **Statistics**: Bayesian inference, prior sensitivity analysis
- **Programming**: R programming, custom function development
- **Data Science**: Feature engineering, model validation, performance metrics
- **Research**: Original data collection, methodology design
- **Communication**: Interactive reporting, professional documentation

## Practical Applications

### **Healthcare AI Deployment Strategy**
1. **Targeted Implementation**: Focus on high-trust demographic segments first
2. **Adaptive Communication**: Tailor AI explanations by political ideology and gender
3. **Technology Integration**: Leverage existing smart device adoption patterns
4. **Bayesian Updating**: Use continuous data collection for inference refinement

## Future Enhancements

- [ ] Hierarchical Bayesian models with MCMC implementation
- [ ] Expanded demographic analysis
- [ ] Longitudinal trust evolution studies
- [ ] Causal inference experimental designs

---

## Contact

**Sam Koscelny**  
Graduate Student, Industrial Engineering & Management  
Oklahoma State University

---

*This analysis shows practical Bayesian inference techniques and provides insights for AI healthcare adoption strategies.*