# Unity_Intro
An introduction to R on the Unity High Performance Computing (HPC) cluster at Ohio State.

The Unity cluster is free for ASC students at Ohio State, however, many students may have questions about working in an HPC enviroment.  I provide a simple example and documentation to get started with `R` on the unity cluster.

Please let me know if you encounter any bugs in the code.

# Contents
1. `ASC_unity_R_intro.Rmd`: The R markdown file describing everything to run the tutorial, and commands to use.
2. `fake_data.rdata`: The simulated data for the demostration.
3. `generate_fake_data.R`: The script used to simulate the fake data.
4. `toy_function.R`: The `R` function to run on the cluster.
5. `demo_pbs.pbs`: The sample `.pbs` file.  

## Note
You will need to change `username.N` to your name.number in the both `.pbs` file, and the command line `scp` code in the markdown file.

## Acknowledgements
Many thanks to Henry Law @hrluo for the parallel bootstrap example, and for extending the discussion on using Windows.
