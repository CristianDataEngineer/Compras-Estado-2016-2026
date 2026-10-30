# semantic

Vistas. No copian filas y no tienen `INSERT`. Las métricas leen `ordenes`. El orden de las filas se pide al leer, no dentro de la vista. El filtro de año también se pide al leer.

## ordenes

Una fila es una orden, con el nombre de la compra y los nombres del organismo y de la oficina.

| Columna | Tipo |
|---|---|
| orden_id | entero largo |
| compra_id | entero largo |
| Documento_Contractual | texto |
| Tipo | texto |
| Monto | decimal (15, 2) |
| Moneda | texto |
| Ejercicio | entero |
| CUIT | texto |
| Descripcion_Proveedor | texto |
| Rubros | texto |
| Fecha_de_Adjudicacion | fecha y hora |
| Numero_Proceso | texto |
| Nombre_del_Proceso | texto |
| Monto_Estimado | decimal (15, 2) |
| Nro_SAF_orden | entero |
| Descripcion_SAF_orden | texto |
| Nro_SAF_compra | entero |
| Descripcion_SAF_compra | texto |
| Nro_UOC_orden | entero |
| Descripcion_UOC_orden | texto |
| Nro_UOC_compra | entero |
| Descripcion_UOC_compra | texto |

El año es el de la orden. El organismo de la orden y el de la compra van los dos, porque el nombre puede haber cambiado. Los id de organismo y de oficina no entran: entran los nombres.

## monto_por_proveedor_anio

Una fila es un proveedor, en un año y en una moneda.

| Columna | Tipo |
|---|---|
| CUIT | texto |
| Descripcion_Proveedor | texto |
| Ejercicio | entero |
| Moneda | texto |
| monto_total | decimal (15, 2) |
| ordenes | entero largo |

`monto_total` suma `Monto`. `ordenes` cuenta las órdenes de esa fila. Pesos y dólares quedan en filas distintas. El CUIT es el texto que llegó: un dígito de más deja al mismo proveedor en dos filas. El año vacío queda en una fila con `Ejercicio` nulo.

## rubros

Una fila es una categoría.

| Columna | Tipo |
|---|---|
| rubro | texto |
| ordenes | entero largo |

`Rubros` trae varias categorías separadas por `;`. Cada categoría cuenta las órdenes en las que aparece. La misma orden escrita dos veces en la misma categoría cuenta una. El monto no se suma: la misma plata quedaría en las dos categorías. Una orden sin texto en `Rubros` no entra.

## organismo

Una fila es el organismo de la orden, en una moneda.

| Columna | Tipo |
|---|---|
| Descripcion_SAF_orden | texto |
| Moneda | texto |
| ordenes | entero largo |
| monto_total | decimal (15, 2) |

Es el organismo que figura en la orden. Pesos y dólares van aparte.

## oficina

Una fila es la oficina de la orden, en una moneda.

| Columna | Tipo |
|---|---|
| Descripcion_UOC_orden | texto |
| Moneda | texto |
| ordenes | entero largo |
| monto_total | decimal (15, 2) |

Es la oficina que figura en la orden. Pesos y dólares van aparte.

## total_por_anio

Una fila es un año y una moneda.

| Columna | Tipo |
|---|---|
| Ejercicio | entero |
| Moneda | texto |
| ordenes | entero largo |
| monto_total | decimal (15, 2) |

El año vacío queda en su propia fila. Un filtro por un año, por ejemplo 2024, no la trae.

## estimado_adjudicado

Una fila es una compra, en una moneda.

| Columna | Tipo |
|---|---|
| compra_id | entero largo |
| Numero_Proceso | texto |
| Nombre_del_Proceso | texto |
| Monto_Estimado | decimal (15, 2) |
| Moneda | texto |
| monto_adjudicado | decimal (15, 2) |
| ordenes | entero largo |

`Monto_Estimado` es el monto publicado y se escribe una vez. `monto_adjudicado` es la suma de las órdenes de esa compra en esa moneda. Una orden sin compra no entra, porque no hay estimado contra qué comparar.
