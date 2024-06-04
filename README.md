# Modular B-DNA model kit

A structurally-accurate, modular, and articulating B-DNA model kit optimized for desktop FDM 3D-printers.

![DOI](https://img.shields.io/badge/DOI-12345678-blue)

## Features

1. TBD

2. TBD

3. TBD

4. TBD

## Catalog

### STL Files

- `adenine.stl`, `thymine.stl`, `cytosine.stl`, `guanine.stl`
    - Nucleobase pieces
- `backbone.stl`
    - Backbone piece with no built-in articulation
- `backbone_artic_o.stl`
    - Same as `backbone.stl` but with built-in articulation at C3-O bond
- `backbone_artic_2.stl`
    - Same as `backbone.stl` but with built-in articulation at C3-O and C4-C5 bond.
- `endcap_o.stl`, `endcap_p.stl`
    - 5' and 3' end caps respectively.

### OpenSCAD "Library" Modules

- `affine_transformation.scad`
    - Maps junctions onto models. Check module for more information
- `all-junctions.scad`
    - Generates the varoius junctions utilized throughout the model
- `global_variables.scad`
    - Global variables used by all OpenSCAD scripts
- `two_point_cylinder.scad`
    - Generates a cylinder between two arbitrary points

## References

The aesthetic choice of nucleobases is modified from [Folding DNA model kit.](https://www.thingiverse.com/thing:714312) by [Michael Kupier](https://www.thingiverse.com/mkuiper/designs) released under the [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) License.

Design of junctions inspired by the following paper:

- Goodwin-Schoen, C. M., & Taylor, R. E. (2023). Modular, Articulated Models of DNA and Peptide Nucleic Acids for Nanotechnology Education. The Biophysicist. https://doi.org/10.35459/tbp.2022.000225

B-DNA structure reference: https://doi.org/10.2210/pdb2BNA/pdb

- Positions of atom #352, #365~#376 and #385 are used to generate the backbone piece.

## License

The entirety of this work, including both the STL files and the OpenSCAD scripts that generate them, is licensed under the [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/) License.

<img src="./others/readme-images/by-nc-sa.png" width="150"/>
