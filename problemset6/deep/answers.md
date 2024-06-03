# From the Deep

In this problem, you'll write freeform responses to the questions provided in the specification.

## Random Partitioning

This approach allows for the sharding of databases, which is good when you are trying to evenly distribute loads. This however, does not require distributed loads of data, and therefore should opt to keep data in one database for now.

## Partitioning by Hour

This approach allows for a even distribution of boat information storage usage. But, this can lead to inefficencies when attempting to find the data we are looking for.

## Partitioning by Hash Value

This query allows for the partition of data by time values effectively as the hash value will act as a key to search the requried timestamp value fast and effectively.
