#include <stdio.h>

int find(int *v1, int *v2, int dim1, int dim2){
    int z = 0, k = 0;
    for(int j = 0; j<=(dim1-dim2); j++){
        for(int i = 0; i<dim2; i++){
            if(v1[j+i] == v2[i])
                z++;
        }
        if(z == dim2)
            k++; //return j;
        z = 0;
    }
    return k;
}

int main(){
    int dim1, dim2;
    printf("\nInserisci dim1 e dim2: ");
    scanf("%d%d", &dim1, &dim2);

    int i=0, V1[dim1], V2[dim2];
    for(i = 0; i<dim1; i++)
    {
        printf("\nInserisci V1[%d]: ", i+1);
        scanf("%d", &V1[i]);
    }

    for(i = 0; i<dim2; i++)
    {
        printf("\nInserisci V2[%d]: ", i+1);
        scanf("%d", &V2[i]);
    }

    printf("\nV1: ");
    for(i = 0; i<dim1; i++)
        printf("%d ", V1[i]);

    printf("\nV2: ");
    for(i = 0; i<dim2; i++)
        printf("%d ", V2[i]);

    printf("\nk: %d\n", find(V1, V2, dim1, dim2));

    return 0;
}