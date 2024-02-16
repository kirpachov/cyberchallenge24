# Script per automatizzare i test
Prende in input un eseguibile e lo chiama verificando che gli input e gli output corrispondano. Ci sarà una cartella input con file che seguano tutti lo stesso schema di nomi ma che terminano con 0,1,2,3,... e per ciascun input ci sarà un file di output.
```
| - executable
| - inputs/
| -       input0.txt
| -       input1.txt
| - outputs/
| -       output0.txt
| -       output1.txt
```

Lo scriptino verificherà la struttura delle cartelle e poi eseguirà qualcosa tipo:
```bash
cat inputs/input0.txt | executable > /tmp/test<hash>.txt
diff /tmp/test<hash>.txt outputs/output0.txt > /tmp/diff0<hash>.txt
# If any diff, show diff and stop execution. Otherwise go on.
```
