local funcions = require("deivis.snippets.funcions.funcions")

return {

    s(
        't',
        {
            t({'{','  "termo": "'}),i(1),t('",'),
            t({'','  "acepcions": [','    {'}),
            t({'','      "lingua": {'}),
            t({'','        "gl": {'}),
            t({'','          "termo": "'}),f(funcions.copy, 1),t('",'),
            t({'','          "definicion": "'}),i(2),t('",'),
            t({'','          "sinonimos": []'}),
            t({'','        }'}),
            t({'','      }'}),
            t({'','    }'}),
            t({'','  ],'}),
            t({'','  "relacionadas": [],'}),
            t({'','  "ten_ecuacions": false,'}),
            t({'','  "ten_figuras": false'}),
            t({'','},'}),
        }
    )

}
