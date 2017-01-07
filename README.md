**This project is incomplete and currently in a state of active development. Initial release upcoming. Please do not attempt to run yet.**

imfml
======
Generative and mutation-based image fuzzer in OCaml. Randomly mutates or generates instances of simple images (ppm format), which are passed to the program under test as input to audit trust boundaries.

Background
------
Put simply, fuzzing involves passing randomized inputs at a program iteratively until unexpected behavior occurs. Observation and analysis of such unexpected behavior (e.g., `SEGEV`) allows an opportunity for exploitation or security reinforcement.

Trust boundaries, parts of a program that are exposed to potential attackers, must be audited with careful attention. Simple unit testing, while a valid reductionist method to infer if an implementation meets some specification, fails to probe a large portion of the possible input space of these attack surfaces. Emergent behavior, if left unaddressed, may pose liabilities as exploitation targets, so fuzzing is a necessary secondary measure of prevention.

Generative and mutation-based fuzzing fall into the category of black-box fuzzing, which involves fuzzing without knowledge of the underlying source code being necessary. Blackbox testing is cheap (computationally and in terms of its generality) but useful. Mutation testing involves randomly changing a seed that originates from a valid precursor; Generative fuzzing requires the use of a specification to generate well-formed data from scratch.

Overview:
------
This project serves as a *proof of concept*, leveraging the advantage of OCaml's typing system to represent image data in a way that is general to both generative and mutation-based systems.An extremely simple image representation, PPM, may either be generated from an encoded specification or produced as a mutation of a prior existing PPM.

At runtime, these randomized images are temporarily written to disk in the PPM format and piped to the software under test, which is assumed to take an PPM file as input.

A command-line monitor observes the program under test for unexpected behavior, like segmentation faults. This process is repeated a specificed number of times while issues are logged.

The transcript of such fuzzing is presented to the user of the fuzzer for analysis.

Design:
------
The mutation-based component parses data using a generic parsing combinator (Angstrom, which is based on Haskell's Parsec Library) to read PPM files from disk. Read images are stored in memory as instances of type PPM, then mutated and used in fuzzing. Alternatively, PPM type instances are generated randomly then used in fuzzing.

Use:
------
A command-line interface is not yet designed.
