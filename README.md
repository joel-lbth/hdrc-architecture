# hdrc architecture

## conceptual design of a trusted research environment

repo using [structurizr-lite](structurizr-lite), to render this project in a local website, download structurizr-lite and run with this command:

```sh
java -jar /path/to/structurizr-lite.war /path/to/project
```

...as well as enabling you to create and manage C4 diagrams, structurizr also provides features for [documentation](https://structurizr.com/help/documentation) and [architectural decision recording](https://structurizr.com/help/decision-log) giving technical architects the core toolkit they require to iteratively design, document, and formalise a system architecture.

The documentation feature is _very_ useful: you can write a markdown document _and_ embed multiple interactive C4 diagrams within it, all presenting different perspectives on aspects of your design. This enables you to create a rich system guidebook presenting a range of perspectives across the zoom hierarchy.

The architectural decision record feature is also useful, situated as it is, alongside the models and documentation that express those decisions.

## repo contents

```sh
├── .gitignore - don't version structurizr-lite.war, but do download it though!
├── README.md
├── adrs - architectural decision record logging
│   └── 0001-record-architecture-decisions.md
├── docs
│   └── workshop.md - the main documentation file in this repo
├── index.html - a self-contained render of workshop.md, the diagrams are statically presented however
├── workspace.dsl - the source code
└── workspace.json - a serialisation of the interactive diagrams
```