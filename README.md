# Towards federated feature selection: logarithmic division for resource-conscious methods

This repository mainly includes:
* Codes of the modified methods required for the reproducibility of the experiments described in the article proposed.
* Auxiliary functions for the correct functioning of the experimentation conducted.

## Methods source codes

The different implementations used for the development of the experimental process are provided. In each of the folders, each version of MIM and JMI can be found, as well as the function for calculating the mutual information. The following versions are provided:

* Centralised
1. **Double-precision floating-point version**. The [Base_double_precision](Base_double_precision) folder contains the base versions of the methods. These are used as the baseline for the calculation of the TPR measurement.
2. **Fixed-point version**. These are compared against the logarithmic division versions. They are located in the [Base_fixed_point](Base_fixed_point) folder.
3. **Fixed point and logarithmic division version**. The [Centralised_Logarithmic_division](Centralised_Logarithmic_division)  folder provides the MIM and JMI methods using fixed-point representation and resorting to logarithmic division. 
* Federated
4. **Federated version in fixed point and logarithmic division**. Federated versions of the methods in reduced precision and using logarithmic division can be found in the [Federated_Logarithmic_division](Federated_Logarithmic_division) folder.

## Auxiliary functions
In the [Utils](Utils) folder, several auxiliary functions necessary for the proper functioning of the project can be found.
1. Functions `disc_dataset_equalwidth` and `divide_data`. They are responsible for the discretisation and division of the data in an Independent and identically distributed (IID) way for the simulation of the federated environment.
2. Implementation of logarithmic division.
3. Folders [f_d_floatp](f_d_floatp) and [fixp](fixp). These contain the implementation of fixed-point arithmetic.

> [!IMPORTANT]
> * The contents of the `f_d_floatp` and `fixp` folders belong to the work done by Gerard Meurant and modified by Samuel Suárez Marcote. The basic documentation is accessible via [gerard-meurant.fr](https://gerard-meurant.fr/).