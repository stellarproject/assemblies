# Assemblies

![Assembly](assembly.jpg)

This repo contains build manifests for creating Stellar Assemblies.  These are core components that are the foundation for the system.

# Build
Building assemblies requires [vab](https://github.com/stellarproject/vab).

To build an individual assembly:

`make containerd`

To make all assemblies:

`make`

To specify a different namespace:

`make IMAGE_NAMESPACE=ehazlett containerd`

To specify `vab` args:

`make VAB_ARGS=-p containerd`

[Photo by Frans Van Heerden on Pexes](https://www.pexels.com/photo/grey-and-orange-spaceship-700015/)
