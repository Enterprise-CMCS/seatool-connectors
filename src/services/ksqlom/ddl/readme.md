# DDL

DDL or data definition layer, contains the SQL files which are parsed and concatenated into a single file that is handed off
to the ksqlDB database during deploy time in order to create the requisite streams and tables that will be hosted within the
ksqlDB database.

## Structure

The directory structure can contain any level of nesting. By default, the structure is iterated in alphanumeric sort order,
but an optional manifest file, `manifest.js`, may be applied to determine the sort order of any given directory. This manifest
file must contain an array of all items within the directory structure in the order in which each item will be parsed, but only
file with a `.sql` extension will be parsed, and this extension is not case dependent. This array must be assigned to the
manifest attribute within the module exports. See the following example:

```
module.exports.manifest = [
  "global_config.sql",
  "orders",
  "inventory",
  "users"
  "fulfillment_centers"
];
```

If any items exist a level in which a manifest file exists, and those items are not listed in the manifest, the sort order
in which the items are parsed cannot be guaranteed.

## Result

The result of the compilation process, is that all of the files with a `.sql` file extension are parsed in the default, or
prescribed order, and all contents concatenated into `headlessSqlContents` variable. This variable is echoed in the standard
input within the headless ksqlDB instance during deploy time, into a file in the following location: `/home/appuser/headless.sql`.
This file is referenced in the ksqlDB configuration and is used to define the requisite streams and tables to be deployed in ksqlDB.
