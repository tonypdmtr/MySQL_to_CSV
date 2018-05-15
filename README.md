# MySQL_to_CSV
Convert MySQL 'framed' table into CSV   

Example input:
```
+-------------+------------------+-------------------------------+-------------+
| pet_id      | pet_identity_id  | identity_value                | pet_species |
+-------------+------------------+-------------------------------+-------------+
|       77626 |          3140819 | dominic_dog@example.com       | dog         |
|       77625 |          3140818 | missy_miauw@example.com       | cat         |
|       77622 |          3140815 | shelly@example.com            | aardvark    |
|       77583 |          3140776 | monster_moo@example.com       | cow         |
+-------------+------------------+-------------------------------+-------------+`
```
Example output:
```
"pet_id"|"pet_identity_id"|"identity_value"|"pet_species"
77626|3140819|"dominic_dog@example.com"|"dog"
77625|3140818|"missy_miauw@example.com"|"cat"
77622|3140815|"shelly@example.com"|"aardvark"
77583|3140776|"monster_moo@example.com"|"cow"
```