**This project is incomplete and currently in a state of active development. Initial release upcoming. Please do not attempt to run yet.**

imfml
======
Generative image fuzzer in OCaml. Randomly produces instances of a simple image format: ppm. Generated data are passed to the program under test as input to audit trust boundaries.

Background
------
Put simply, fuzzing involves passing randomized inputs at a program iteratively until unexpected behavior occurs. Observation and analysis of such unexpected behavior (e.g., `SEGEV`) allows an oppertunity for exploitation or security reinforcement.

Trust boundaries, parts of a program that are exposed to potential attackers, must be audited with careful attention. Simple unit testing, while a valid reductionist method to infer if an implementation meets some specification, fails to probe a large portion of the possible input space of these attack surfaces. Emergent behavior, if left unaddressed, may pose liabilities as exploitation targets, so fuzzing is a necessary secondary measure of prevention.

Generative fuzzing falls into the category of black-box fuzzing, which involves fuzzing without knowledge of the unlying source code being necessary. Blackbox testing is cheap (computationally and in terms of its generality) but useful. Generative fuzzing requires the use of a specification to generate well-formed data from scratch.

Overview:
------
This project serves as a *proof of concept*, leveraging the advantage of OCaml's type system to represent image data. An extremely simple image representation, PPM, may either be generated from an encoded specification grammar.

At runtime, these randomized images are temporarily written to disk in the PPM format and piped to the software under test, which is assumed to take an PPM file as input.

A command-line monitor observes the program under test for unexpected behavior, like segmentation faults. This process is repeated a specificed number of times while issues are logged.

The transcript of such fuzzing is presented to the user of the fuzzer for analysis.

Design:
------
PPM type instances are generated randomly then used in fuzzing.
ead images are stored in memory as instances of type PPM, then mutated and used in fuzzing. Alternatively,

In the future, this system might be generalized with the addition of mutation testing. The mutation-based component might parse data using a generic parsing combinator (e.g., Angstrom, which is based on Haskell's Parsec Library) to read PPM files from disk. However, Angstrom's documentation is prohibitively limited. Alternative, less powerful parsing combinators are currently being explored
