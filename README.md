# Quick Description

**Programmer:shipit:**: Zakaria Abdelmoiz DAHI, University of Malaga, Spain. 

**About:** This repositiory implements the binary variants of the algorithms devised and studied in [1] that solves the users' mobility tracking in cellular networks.

- [1] **Z.A. Dahi**, E. Alba, The grid-to-neighbourhood relationship in cellular GAs: from design to solving complex problems. Soft Comput 24, 3569–3589 (2020). https://doi.org/10.1007/s00500-019-04125-w

## **How :green_book:** 

- Depending on what you want to study or used, you can navigate to the folder `Fitness` for running the algorithms or `ratio` for studying the ratio evolution.
- Then, depending on the type of replacemnt you want o use, you can use either `Synchronous` or `Asynchronous`.
- Then, depending on the type of the variant you can run `Online dynamic`, `Ofline dynamic` or satic ones.
- Finally, depending on the adaption you can choose you variant `Genotype`, `Phenotype`, or `Genotype and phenotype`, `Narrow to Square`, `Square to Narrow`, `Rectangular`, `Narrow` and `Squared`.


## **Folders Hiearchy :open_file_folder:**
    
- `Fitness`: contains the code for solving the mobility tracking problem.
    - `Asynchrnous`: Contains the code of the variants using asynchronous replacement.
        - `Preprogramed_Dynamic_Inline`: for the inline adaptation.
            - `Genotype`: uses the genotype adaptation.
            - `Phenotype`: uses the phenotype adaptation.
            - `Phenotype_Genotype`:  uses the phenotype and genotype adaptiations.
        - `Preprogramed_Dynamic_Offline`: for the offline adaptation.
            - `Narrow_to_Square`: for the narrow to square adaptation.
            - `Squared_to_Narrow`: for the square to narrow grid adaptation.
        - `Static`: Uses a static grid shape.
            - `Narrow`: for the narrow grid shape.
            - `Rectangular`: for the rectangular grid shape.
            - `Squared`: gor the squared grid shape.
    - `Synchrnous`: The same as for `asynchrnous` but this time when using the `synchronous` replacement.

- `ratio`:
    - `Asynchrnous`: Contains the code of the variants using asynchronous replacement.
        - `Preprogramed_Dynamic_Inline`: for the inline adaptation.
            - `Genotype`: uses the genotype adaptation.
            - `Phenotype`: uses the phenotype adaptation.
            - `Phenotype_Genotype`:  uses the phenotype and genotype adaptiations.
        - `Preprogramed_Dynamic_Offline`: for the offline adaptation.
            - `Narrow_to_Square`: for the narrow to square adaptation.
            - `Squared_to_Narrow`: for the square to narrow grid adaptation.
    - `Synchrnous`: The same as for `asynchrnous` but this time when using the `synchronous` replacement.


    - `Results`: Once executed the results are stored in excel files with name Network_a_bxc, where a represent the ID of networks of such shape, b and c represent the number of cells in the width and height of the network.
    
## **Demo :movie_camera:**
    
- Please refer to the original paper [HERE](https://link.springer.com/article/10.1007/s00500-019-04125-w) for more detailed results and discussions.
