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
   * `model_M1.RData`, `model_M2.RData`, `M3_results.RData` **: RData files containing the saved output from the JAGS model fitting procedures for each model.

## Purpose

The primary purpose of this project is to:
1.  Apply Bayesian hierarchical modeling to analyze human reinforcement learning behavior.
2.  Compare different model complexities (non-hierarchical, hierarchical, and hierarchical with additional parameters) to determine which best explains the observed data.
3.  Characterize individual differences in learning and decision-making parameters.
4.  Provide a reproducible workflow for conducting similar analyses (frequentist approach).

## Data Source

The behavioral data used in this project is sourced from:
* **Gershman, S. J., Markman, A. B., & Otto, A. R. (2015).** The role of working memory in reinforcement learning. *Journal of Neuroscience*, 35(34), 11820-11829.

The data provides trial-by-trial records of choices and outcomes from a two-armed bandit task across multiple participants and experiments.

## Related Papers & Inspirations

This project draws inspiration from key literature in computational psychiatry and reinforcement learning, particularly regarding Bayesian hierarchical modeling of behavioral data:

* **Gershman, S. J., Markman, A. B., & Otto, A. R. (2015).** The role of working memory in reinforcement learning. *Journal of Neuroscience*, 35(34), 11820-11829. (Primary data source and conceptual framework for the task design).
* **Gershman, S. J. (2021).** Computational psychiatry: A primer. *Journal of Mathematical Psychology*, 102602. (Provides foundational concepts for applying computational models to behavioral data).
* **Wiecki, T. V., Sofer, D., & Frank, M. J. (2013).** Posterior predictive checks for computational models of behavior. *Journal of Mathematical Psychology*, 57(3), 127-138. (Guidance on implementing and interpreting posterior predictive checks in behavioral modeling).
* **Ahn, W. Y., Busemeyer, J. R., Wagenmakers, E. J., & Stout, J. C. (2008).** Comparison of computational models of reinforcement learning. *Journal of Mathematical Psychology*, 52(4), 195-207. (General inspiration for comparing different RL model architectures).
