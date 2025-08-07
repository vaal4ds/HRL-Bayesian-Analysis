# Hierarchical Reinforcement Learning Bayesian Analysis

## Project Overview

This project conducts a comprehensive Bayesian hierarchical analysis of human behavior in a reinforcement learning (RL) task. Leveraging a dataset from a seminal behavioral study, we investigate reinforcement-driven decision-making using various Q-learning models implemented within a Bayesian framework using JAGS. The analysis focuses on understanding individual differences in cognitive parameters (learning rate, bias, inverse temperature, and stickiness) and comparing different model complexities.

## Contents

This repository contains all the necessary code and materials to reproduce the analysis:

* **`HRL_Avino.Rmd`**: The primary R Markdown script containing the full analysis, including data loading, preprocessing, model fitting (JAGS calls), convergence diagnostics, posterior interpretation, and posterior predictive checks. This is the main document for understanding the project's workflow.
* **`HRL_Avino.html`**: The knitted HTML output of the `HRL_Avino.Rmd` file, providing a complete, readable report of the analysis.
* **`preprocessing.R`**: A supplementary R script dedicated to the detailed preprocessing of the raw behavioral data, transforming it into the subject-by-trial matrices required for the JAGS models. This script also handles the creation of the `stickiness` variable.
* **JAGS Model Files**:
    * `Non_hierarchicalM1.jags`: The JAGS model definition for the **non-hierarchical Q-learning model (Model 1)**. This model assumes a single set of cognitive parameters (learning rate, bias, inverse temperature) shared across all participants, serving as a baseline.
    * `Hierarchical_M2.jags`: The JAGS model definition for the **hierarchical Q-learning model (Model 2)**. This model extends Model 1 by allowing individual differences, where each subject's learning rate, bias, and inverse temperature are drawn from group-level distributions.
    * `justanotherM3.jags`: The JAGS model definition for the **hierarchical Q-learning model with an additional stickiness parameter (Model 3)**. This model builds upon Model 2 by incorporating a subject-specific stickiness parameter, also drawn from a group-level distribution, to account for the tendency to repeat previous choices. This version utilizes a single learning rate and an Inverse-Wishart prior for the covariance matrix of the hierarchical parameters.
* **Data Files**:
    * `behavioral_data/GershmanData_d1.csv`, `behavioral_data/GershmanData_d2_block1_test.csv`, etc.: The raw behavioral data files used in the analysis.
    * `rl_data.RData`: An RData file containing the preprocessed and aggregated data, ready for direct use in the JAGS models.
* **Models Output**:
   * `model_M1.RData`, `model_M2.RData`, `M3_results.RData` : RData files containing the saved output from the JAGS model fitting procedures for each model.

## Purpose

The primary purpose of this project is to:
1.  Apply Bayesian hierarchical modeling to analyze human reinforcement learning behavior.
2.  Compare different model complexities (non-hierarchical, hierarchical, and hierarchical with additional parameters) to determine which best explains the observed data.
3.  Characterize individual differences in learning and decision-making parameters.
4.  Provide a reproducible workflow for conducting similar analyses (frequentist approach).

## Data Source

* **Gershman, S. J. (2016).** [Empirical priors for reinforcement learning models
 *Github repository*](https://github.com/sjgershm/RL-models).

* **Camilla van Geen (2021)**[Hierarchical Bayesian models of reinforcement learning: tutorial and model comparisons *OSF*](https://osf.io/5r2hf/files/osfstorage?view_only=)

The data provides trial-by-trial records of choices and outcomes from a two-armed bandit task across multiple participants and experiments.

## Related Papers & Inspirations

This project draws inspiration from key literature in computational psychiatry and reinforcement learning, particularly regarding Bayesian hierarchical modeling of behavioral data:

* **Gershman, S. J. (2016).** [Empirical priors for reinforcement learning models
 *Journal of Neuroscience*]([https://github.com/sjgershm/RL-models](https://www.sciencedirect.com/science/article/pii/S0022249616000080?via%3Dihub))
  
* **Camilla van Geen, Raphael T.Gerraty (2021).**  [Hierarchical Bayesian models of reinforcement learning: Introduction
 and comparison to alternative methods. *Journal of Mathematical Psychology*](https://www.sciencedirect.com/science/article/pii/S0022249621000742?via%3Dihub).



