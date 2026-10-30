# silver

Acá aparecen los tipos y las claves. El cruce entre las dos tablas es `Numero_Proceso`. Una compra está una vez en convocatorias y puede tener varias órdenes en adjudicaciones.

El texto vacío pasa a nulo antes de convertir. No se pasa nada a minúsculas. Un monto nulo sigue nulo: no se inventa un cero.

## convocatorias

Una fila es un proceso de compra. `Numero_Proceso` no se repite.

| Columna | Tipo |
|---|---|
| Numero_Proceso | texto |
| Nro_SAF | entero |
| Descripcion_SAF | texto |
| Nro_UOC | entero |
| Descripcion_UOC | texto |
| Tipo_de_Procedimiento | texto |
| Modalidad | texto |
| Apartado_Directa | texto |
| Ejercicio | entero |
| Fecha_de_Publicacion | fecha y hora |
| Fecha_de_Apertura | fecha y hora |
| Etapa | texto |
| Alcance | texto |
| Nombre_del_Proceso | texto |
| Objeto_del_Proceso | texto |
| Monto_Estimado | decimal (15, 2) |
| Tipo_de_Operacion | texto |

`Ejercicio` es el año, no una fecha. Las dos fechas llegan como `dd/MM/yyyy hh:mm:ss a.m.` o `p.m.` y quedan en fecha y hora. Al monto se le saca la coma de miles antes de convertirlo.

`Apartado_Directa`: si el procedimiento es contratación directa y el apartado viene vacío, queda `Sin especificar`. Si viene vacío en otro procedimiento, queda `No aplica`. El resto del texto queda igual.

Una fila sin `Numero_Proceso` no entra. `Etapa` y `Modalidad` nulas siguen nulas. El texto `Sin Modalidad` se conserva.

## adjudicaciones

Una fila es una orden de compra. La clave es `Numero_Proceso` + `Documento_Contractual` + `Tipo`.

| Columna | Tipo |
|---|---|
| Numero_Proceso | texto |
| Nro_SAF | entero |
| Descripcion_SAF | texto |
| Nro_UOC | entero |
| Descripcion_UOC | texto |
| Unidad_Ejecutora | texto |
| Tipo_de_Procedimiento | texto |
| Modalidad | texto |
| Apartado_Directa | texto |
| Ejercicio | entero |
| Fecha_de_Adjudicacion | fecha y hora |
| Rubros | texto |
| CUIT | texto |
| Descripcion_Proveedor | texto |
| Documento_Contractual | texto |
| Tipo | texto |
| Monto | decimal (15, 2) |
| Moneda | texto |
| Tipo_de_Operacion | texto |
| Fecha_de_perfeccionamiento_OC | fecha y hora |

Fechas, año, montos y apartado se tratan como en convocatorias. `CUIT` queda como llegó: no se valida ni se corrige el dígito de más. `Rubros` queda en una sola celda, con los textos separados por `;`.

Hay 73 pares de prórroga iguales. En cada par, una fila tiene fecha de adjudicación y la otra no. Se queda la que tiene fecha. Esas 73 copias siguen en bronze.

Dos órdenes sin número de documento se quedan: la ampliación de Fuerza Aérea y el SPR de SENASA. Tienen `Tipo`, así que no se mezclan con otras órdenes del mismo proceso.
