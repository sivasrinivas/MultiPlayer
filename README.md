# MultiPlayer
===========
This project involves developing a multi player “tile matching game”. The user has a set of random tiles displayed before him. Each tile would be related to another one in the set. The purpose of the game is for each user to find pairs of related tiles in consecutive steps. The scoring here is based on the maximum number of related pairs a user would uncover and also how soon he or she would uncover. To make it even more interesting, the game is included with a time constraint, after which the game shall end.
Several factors had to be taken into account for implementing this game, for instance setting up the communication between client and server. Also many things had to be implemented concurrently rather than sequentially to reduce the complexity and to accommodate the requirement (for instance, it is a multi player game). When concurrency had come into play, the most important issue to take care was that of correctness.