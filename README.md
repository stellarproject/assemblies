# Assemblies

![Assembly](assembly.jpg)

This repo contains build manifests for creating Stellar Assemblies. These are core components that are the foundation for the system.
As the artifact from these builds are scratch images they are intended to be used with [TerraOS](https://github.com/stellarproject/terraos).

# Build

Building assemblies requires [Vab](https://github.com/stellarproject/vab).

To build an individual assembly:

`make containerd`

To make all assemblies:

`make`

To specify a different namespace:

`make IMAGE_NAMESPACE=ehazlett containerd`

To specify `vab` args:

`make VAB_ARGS="--push" containerd`

[Photo by Frans Van Heerden on Pexels](https://www.pexels.com/photo/grey-and-orange-spaceship-700015/)
