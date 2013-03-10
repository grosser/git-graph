Make graphs from your git history

Install
=======

    gem install git-graph

Usage
=====

```Bash
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

# number of gems the project depends on
???

# number of lines of code vs lines of test
```

If the script fails the previous output is assumed.

```
--interval day|week|year
```

TODO
====
 - interval month -> first of every month ?
 - interval year -> same day on every year (leap-year adjustment)
 - refactor into a class


Author
======
[Michael Grosser](http://grosser.it)<br/>
michael@grosser.it<br/>
License: MIT<br/>
[![Build Status](https://travis-ci.org/grosser/git_graph.png)](https://travis-ci.org/grosser/git_graph)
