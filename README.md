# Cosing

This is a gem to make the COSING database easier to work with.

Created by the team at [inhouse.work](https://www.inhouse.work)

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add cosing

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install cosing

## Usage


```ruby
database = Cosing.load
database.ingredients #=> Hash<ID, Ingredient>
database.ingredients.values.sample(2)
database.save("output.json", pretty: true) # Will save the whole database to a json file
```

```json
[
  {
    "reference_number":"90000",
    "inci_name":"ECKLONIA CAVA WATER",
    "inn":"",
    "ph_eur_name":"",
    "cas_numbers":[],
    "einecs_numbers":[],
    "description":"Ecklonia Cava Water is the aqueous solution of the steam distillates obtained from the whole plant, Ecklonia cava, Lessoniaceae.",
    "restrictions":[],
    "functions":["SKIN PROTECTING"],
    "regulations":[]
  },
  {
    "reference_number":"32549",
    "inci_name":"CETEARTRIMONIUM CHLORIDE",
    "inn":"",
    "ph_eur_name":"",
    "cas_numbers":["68002-62-0"],
    "einecs_numbers":["268-075-4"],
    "description":"Quaternary ammonium compounds, C16-18-alkyltrimethyl, chlorides",
    "restrictions":["V/44"],
    "functions":[
        "ANTISTATIC",
        "HAIR CONDITIONING",
        "PRESERVATIVE"
    ],
    "regulations":[
      {
        "annex":"Cosing Annex V",
        "cas_numbers":[
            "17301-53-0",
            "57-09-0",
            "112-02-7",
            "1119-94-4",
            "112-00-5",
            "1120-02-1",
            "112-03-8"
        ],
        "chemical_name":"",
        "cmr":"",
        "ec_numbers":[
            "241-327-0",
            "200-311-3",
            "203-928-6",
            "214-290-3",
            "203-927-0",
            "214-294-5",
            "203-929-1"
        ],
        "identified_ingredients":[
            "BEHENTRIMONIUM CHLORIDE",
            "CETEARTRIMONIUM CHLORIDE",
            "CETRIMONIUM BROMIDE",
            "CETRIMONIUM CHLORIDE",
            "COCOTRIMONIUM CHLORIDE",
            "HYDROGENATED PALMTRIMONIUM CHLORIDE",
            "HYDROGENATED TALLOWTRIMONIUM CHLORIDE",
            "LAURTRIMONIUM BROMIDE",
            "LAURTRIMONIUM CHLORIDE",
            "MYRTRIMONIUM BROMIDE",
            "SOYTRIMONIUM CHLORIDE",
            "STEARTRIMONIUM BROMIDE",
            "STEARTRIMONIUM CHLORIDE",
            "TALLOWTRIMONIUM CHLORIDE"
        ],
        "other_regulations":"",
        "reference_number":"44",
        "regulated_by":"91/184/EEC",
        "regulation":"(EU) No 866/2014",
        "sccs_opinions":[
            {
                "code":"0917/05",
                "description":"Opinion on Alkyl (C16, C18, C22) trimethylammonium chloride - For other uses than as a preservative"
            },
            {
                "code":"1087/07",
                "description":"Opinion on Alkyl (C16, C18, C22) trimethylammonium chloride - For other uses than as a preservative"
            },
            {
                "code":"1246/09",
                "description":"Opinion on Alkyl (C16, C18, C22) trimethylammonium chloride - For other uses than as a preservative"
            }
        ],
        "inn":"Alkyl (C12 -C22) trimethyl ammonium bromide and chloride",
        "maximum_concentration":"0.1%",
        "other_restrictions":"",
        "product_type":"",
        "wording_of_conditions":""
      }
    ]
  }
]
```

## Benchmarks

The library is fast to load on an SSD. You can run the benchmarks by running
`bin/benchmark`

```
                    user     system      total        real
Cosing.load         1.255882   0.048911   1.304793 (  1.314068)
Cosing::Annex.load  0.127545   0.003247   0.130792 (  0.131845)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and the created tag, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/inhouse/cosing.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
