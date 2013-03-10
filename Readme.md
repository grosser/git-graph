Make graphs from your git history

Install
=======

    gem install git-graph

Usage
=====

    # number of lines in the readme as csv
    git-graph --interval day --output csv "cat Readme.md | wc -l"
    2013-02-01,24
    2013-01-31,24
    2013-01-31,22
    ...

    # number of lines in the readme as line-chart (via google charts)
    git-graph --interval day --output chart "cat Readme.md | wc -l"

    # number of lines in the readme as spark-chart
    git-graph --interval day --output chart "cat Readme.md | wc -l"

(if the script fails the previous output is assumed)

Author
======
[Michael Grosser](http://grosser.it)<br/>
michael@grosser.it<br/>
License: MIT<br/>
[![Build Status](https://travis-ci.org/grosser/git_graph.png)](https://travis-ci.org/grosser/git_graph)
