# Exercises 3 & 4 - Pessoas

## Makefile

- Use `make` or `make pessoas` to compile the code and generate the `pessoas` binary.
- Use `make clean` to remove `*.o` files and `mycat` binary.



## Usage

#### Add new person
```
$ ./pessoas -i <name> <age>
```


#### List N persons
```
$ ./pessoas -l <N>
```

#### Update a person's age (v1)
```
$ ./pessoas -u <name> <new_age>
```

#### Update a person's age (v2)
```
$ ./pessoas -o <position> <new_age>
```

## pscript.sh

Script to add N persons

```
$ ./pscript.sh 10000
```