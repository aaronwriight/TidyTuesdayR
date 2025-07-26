## The extended language network: Language selective brain areas whose contributions to language remain to be discovered

This repository contains code and data accompanying: 

Wolna, A., Wright, A., Casto, C., Lipkin, B., & Fedorenko, E. (2025). The extended language network: Language selective brain areas whose contributions to language remain to be discovered. bioRxiv, 2025-04. https://www.biorxiv.org/content/10.1101/2025.04.02.646835v2

## Environment
The environment is a R 4.4.1 environment that makes heavy use of [Tidyverse](https://www.tidyverse.org/packages/), [ggseg](https://github.com/ggseg/ggseg), [emmeans](https://cran.r-project.org/web/packages/emmeans/index.html), and [lmerTest](https://cran.r-project.org/web/packages/lmerTest/index.html), and [patchwork](https://patchwork.data-imaginist.com), among others. To use the exact R environment used in the paper, install it as:

<!--
```
conda env create -f env_drive-suppress-brains.yml
```
-->

## Repository organization
 * [data](./data) # raw data input to script
 
 * [renv](./renv) # renv information
 
 * [images](./images) # images created by scripts
   * [byroi_cortical](./images/byroi_cortical)
   * [byroi_subcortical](./images/byroi_subcortical)
   * [dkt](./images/dkt)
   * [glasser](./images/glasser)
   * [hoCort](./images/hoCort)
   * [hoSubCort](./images/hoSubCort)
   * [main_cortical_figure](./images/main_cortical_figure)
   * [main_subcortical_figure](./images/main_subcortical_figure)
   * [supplemental_plots](./images/supplemental_plots)
    
 * [results](./results) # final results to be shared on osf
   
 * [scripts](./scripts)
 
 <!--
 * [src](./src)
   * [plot_data](./src/plot_data)
   * [run_analyses](./src/run_analyses)
   * [statistics](./src/statistics)
-->
   
 * [tables](./tables)
   * [all_atlases](./tables/all_atlases)
   * [dkt](./tables/dkt)
   * [glasser](./tables/glasser)
   * [hoCort](./tables/hoCort)
   * [hoSubCort](./tables/hoSubCort)
   * [atlas_model_stats](./tables/atlas_model_stats)
   * [gss_model_stats](./tables/gss_model_stats)
   
 * [README.md](./README.md)
 * [Rproj](./extended_language_network.Rproj)

<!--
To populate the `data`, `data_SI`, `model-actv`, and `regr-weights` folders, please see the "Downloading data" section below.

The `data` folder contains a csv file with the event-related data (_brain-lang-data_participant_20230728.csv_; main experiment), a csv file for the blocked experiment (_brain-lang-blocked-data_participant_20230728.csv_), a csv file with the noise ceilings computed based on the event-related data (_NC-allroi-data.csv_), and finally a file with the associated column name descriptions (_column_name_descriptions.csv_). These files are used to run the [Figure_2.ipynb](https://github.com/gretatuckute/drive_suppress_brains/blob/main/src/plot_data/Figure2.ipynb), [Figure_3.ipynb](https://github.com/gretatuckute/drive_suppress_brains/blob/main/src/plot_data/Figure3.ipynb), [Figure_4.ipynb](https://github.com/gretatuckute/drive_suppress_brains/blob/main/src/plot_data/Figure4.ipynb), and [Figure_5.ipynb](https://github.com/gretatuckute/drive_suppress_brains/blob/main/src/plot_data/Figure5.ipynb) notebooks.

The `data_SI` folder contains csv files used to run the [SI_Figures.ipynb](https://github.com/gretatuckute/drive_suppress_brains/blob/main/src/plot_data/SI_Figures.ipynb).

The `env` folder contains the conda yml file _env_drive-suppress-brains.yml_.

The `model-actv` folder contains pre-computed model activations for GPT2-XL (last-token representation). The file _beta-control-neural-T_actv.pkl_ contains the activations for the _baseline_ set in a Pandas dataframe. The rows correspond to sentences, and the columns are multi-indexed according to layer and unit. The first level is layer (49 layers in GPT2-XL) and the second level is unit (1600 units in each representation vector in GPT2-XL). The file _beta-control-neural-T_stim.pkl_ contains the corresponding stimuli metadata in a Pandas dataframe. The two files are row-indexed using the same identifiers. The files _beta-control-neural-D_actv.pkl_ and _beta-control-neural-D_stim.pkl_ contain the activations for the _baseline_ set along with the _drive_/_suppress_ activations (derived via the main search approach).

The `regr-weights` folder contains the encoding model regression weights in the `fit_mapping` subfolder with an additional subfolder according to the parameters that were used to fit the encoding model.

The `results` folder is the default folder for storing outputs from `src/run_analyses`.

The `src` folder contains all code in the following subfolders: 
- `plot_data` contains a notebook that reproduces each of the main figures, as well as a notebook for the SI figures.
-  `run_analyses` contains code to run all main analyses in the paper.
-  `statistics` contains linear mixed effect (LME) statistics (in R).

## Downloading data
To download data used in the paper, run the [download_files.py](https://github.com/gretatuckute/drive_suppress_brains/blob/main/setup_utils/download_files.py) script. By default, it will download the files for the `data` folder. 

The `data` folder contains a csv file with the event-related data (_brain-lang-data_participant_20230728.csv_; main experiment). This file contains brain responses for the left hemisphere (LH) language regions for n=10 participants (n=5 _train_ participants, n=5 _evaluation_ participants) along with various metadata and behavioral data for each sentence (n=10 linguistic properties). The `data` folder also contains a csv file with brain responses for the blocked experiment (_brain-lang-blocked-data_participant_20230728.csv_, n=4 _evaluation_ participants). The folder also contains the noise ceilings computed based on the event-related data on n=5 _train_ participants (_NC-allroi-data.csv_). Finally, the file _column_name_descriptions.csv_ contains descriptions of the content of the columns in these csv files.

Using the additional flags, you can specify whether you want to download the `data_SI` files, the `model-actv` files, and the `regr-weights` files. 
-->

## Analyzing data and generating plots
All code is in `src`. 

- The `src/plot_data` folder contains Jupyter Notebooks that analyze and generate plots for the main results in the paper. 
- The `src/run_analyses` folder contains Python scripts for running analyses. The two main scripts are: 
	1. [/src/run_analyses/fit_mapping.py](https://github.com/gretatuckute/drive_suppress_brains/blob/main/src/run_analyses/fit_mapping.py) fits an encoding model from features from a source model (in this case, GPT2-XL, cached in `model-actv/gpt2-xl`) to the participant-averaged brain data. The script will store outputs in `results` and the fitted regression weights in `regr-weights`.
	2. [/src/run_analyses/use_mapping_external.py](https://github.com/gretatuckute/drive_suppress_brains/blob/main/src/run_analyses/use_mapping_external.py) loads the regression weights from the encoding model and predicts each sentence in the supplied stimulus set.
- The `src/statistics` folder contains R code to run LME models.


## Citation
If you use this repository or data, please cite:

```
@article{Wolna2025,
  bibtex_show = {true},
  title = {The extended language network: Language selective brain areas whose contributions to language remain to be discovered},
  author = {Wolna, Agata and **Wright, Aaron** and Casto, Colton and Lipkin, Benjamin and Fedorenko, Evelina},
  abstract = {Although language neuroscience has largely focused on ‘core’ left frontal and temporal brain areas and their right-hemisphere homotopes, numerous other areas—cortical, subcortical, and cerebellar—have been implicated in linguistic processing. However, these areas’ contributions to language remain unclear given that the evidence for their recruitment comes from diverse paradigms, many of which conflate language processing with perceptual, motor, or task-related cognitive processes. Using fMRI data from 772 participants performing an extensively-validated language ‘localizer’ paradigm that isolates language processing from other processes, we a) delineate a comprehensive set of areas that respond reliably to language across written and auditory modalities, and b) evaluate these areas’ selectivity for language relative to a demanding non-linguistic task. In line with prior claims, many areas outside the core fronto-temporal network respond during language processing, and most of them show selectivity for language relative to general task demands. These language-selective areas of the extended language network include areas around the temporal poles, in the medial frontal cortex, in the hippocampus, and in the cerebellum, among others. Although distributed across many parts of the brain, the extended language-selective network still only comprises ∼1.2% of the brain’s volume and is about the size of a strawberry, challenging the view that language processing is broadly distributed across the cortical surface. These newly identified language-selective areas can now be systematically characterized to decipher their contributions to language processing, including testing whether these contributions differ from those of the core language areas.},
  journal = {bioRxiv},
  year = {2025},
  date = {2024/01/03},
  volume = {},
  issue = {},
  pages = {},
  doi = {10.1101/2025.04.02.646835},
  url = {https://doi.org/10.1101/2025.04.02.646835},
  pdf = {https://www.biorxiv.org/content/10.1101/2025.04.02.646835v2.full.pdf},
  selected = {true},
  recommended_citation = {Wolna, A., Wright, A., Casto, C., Lipkin, B., & Fedorenko, E. (2025). The extended language network: Language selective brain areas whose contributions to language remain to be discovered. *bioRxiv*, 2025-04. https://doi.org/10.1101/2025.04.02.646835.}
}
```

README.md templated from [Greta Tuckute](https://github.com/gretatuckute/drive_suppress_brains/blob/main/README.md) and [Guillaume Noblet](https://github.com/gnoblet/TidyTuesday/blob/main/README.md)

https://github.com/z3tt/TidyTuesday
https://gnoblet.github.io/TidyTuesday/