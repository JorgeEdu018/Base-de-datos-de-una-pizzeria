CREATE TABLE tipo_auto_jchz (
    id_tipo_vehiculo NUMBER
        CONSTRAINT taj_pk PRIMARY KEY,
    descripcion      VARCHAR2(20)
);

CREATE TABLE vehiculo_jchz (
    id_vehiculo      NUMBER
        CONSTRAINT v_pk PRIMARY KEY,
    id_tipo_vehiculo NUMBER,
    numero_licencia  NUMBER
        CONSTRAINT v_nn NOT NULL,
    CONSTRAINT v_fk FOREIGN KEY ( id_tipo_vehiculo )
        REFERENCES tipo_auto_jchz ( id_tipo_vehiculo )
);

CREATE TABLE direccion (
    id_direccion NUMBER
        CONSTRAINT dr_pk PRIMARY KEY,
    calle        VARCHAR2(50)
        CONSTRAINT dr_ca_nn NOT NULL,
    ciudad       VARCHAR2(50)
        CONSTRAINT dr_ci_nn NOT NULL,
    estado       VARCHAR2(50)
        CONSTRAINT dr_es_nn NOT NULL,
    cp           VARCHAR2(50)
        CONSTRAINT dr_cp_nn NOT NULL
);

CREATE TABLE empleado_pizza_jchz (
    id_empleado  NUMBER
        CONSTRAINT em_pk PRIMARY KEY,
    id_direccion NUMBER,
    nombre       VARCHAR2(30)
        CONSTRAINT em_nm_nn NOT NULL,
    telefono     NUMBER
        CONSTRAINT em_tl_nn NOT NULL,
    CONSTRAINT empl_fk FOREIGN KEY ( id_direccion )
        REFERENCES direccion ( id_direccion )
);

CREATE TABLE metodo_pago_jchz (
    id_metodo   NUMBER
        CONSTRAINT mp_pk PRIMARY KEY,
    descripcion VARCHAR(30)
        CONSTRAINT mp_nn NOT NULL
);

CREATE TABLE clientes_jchz (
    id_cliente   NUMBER
        CONSTRAINT cl_pk PRIMARY KEY,
    id_direccion NUMBER,
    id_metodo    NUMBER,
    nombre       VARCHAR2(50)
        CONSTRAINT cl_nm_nn NOT NULL,
    telefono     NUMBER
        CONSTRAINT cl_tl_nn NOT NULL,
    fecha_orden  DATE
        CONSTRAINT cl_da_nn NOT NULL,
    CONSTRAINT cl_dr_pk FOREIGN KEY ( id_direccion )
        REFERENCES direccion ( id_direccion ),
    CONSTRAINT cl_mp_fk FOREIGN KEY ( id_metodo )
        REFERENCES metodo_pago_jchz ( id_metodo )
);

SELECT
    *
FROM
    estatus_jchz;

CREATE TABLE estatus_jchz (
    id_estatus  NUMBER
        CONSTRAINT est_pk PRIMARY KEY,
    descripcion VARCHAR2(35)
        CONSTRAINT ets_nn NOT NULL
);

CREATE TABLE orden_jchz (
    id_orden          NUMBER
        CONSTRAINT ors_pk PRIMARY KEY,
    id_cliente        NUMBER,
    id_empleado_orden NUMBER,
    id_repartidor     NUMBER,
    id_estatus        NUMBER,
    id_vehiculo       NUMBER,
    orden_tomada      DATE
        CONSTRAINT or_nn_ot NOT NULL,
    orden_entragada   DATE
        CONSTRAINT or_nn_oe NOT NULL,
    precio_total      NUMBER
        CONSTRAINT or_nn_pt NOT NULL,
    CONSTRAINT ord_em_fk FOREIGN KEY ( id_empleado_orden )
        REFERENCES empleado_pizza_jchz ( id_empleado ),
    CONSTRAINT ord_cl_fk FOREIGN KEY ( id_cliente )
        REFERENCES clientes_jchz ( id_cliente ),
    CONSTRAINT ord_re_fk FOREIGN KEY ( id_repartidor )
        REFERENCES empleado_pizza_jchz ( id_empleado ),
    CONSTRAINT ord_ve_fk FOREIGN KEY ( id_vehiculo )
        REFERENCES vehiculo_jchz ( id_vehiculo )
);

CREATE TABLE tipo_base_jchz (
    id_base     NUMBER
        CONSTRAINT tb_pk PRIMARY KEY,
    precio      NUMBER
        CONSTRAINT tb_p_nn NOT NULL,
    descripcion VARCHAR2(50)
);

CREATE TABLE tipo_cobertura_jchz (
    id_cobertura NUMBER
        CONSTRAINT cb_pk PRIMARY KEY,
    precio       NUMBER
        CONSTRAINT cb_p_nn NOT NULL,
    descripcion  VARCHAR2(50)
);

CREATE TABLE ordenes_pizza_jchz (
    id_orden     NUMBER,
    numero_pizza NUMBER
        CONSTRAINT op_pk PRIMARY KEY,
    id_base      NUMBER,
    CONSTRAINT op_io_fk FOREIGN KEY ( id_orden )
        REFERENCES orden_jchz ( id_orden ),
    CONSTRAINT op_ib_fk FOREIGN KEY ( id_base )
        REFERENCES tipo_base_jchz ( id_base )
);

CREATE TABLE cobertura_jchz (
    id_orden         NUMBER,
    numero_pizza     NUMBER,
    numero_cobertura NUMBER
        CONSTRAINT cob_pk PRIMARY KEY,
    id_cobertura     NUMBER,
    CONSTRAINT cb_ord_fk FOREIGN KEY ( id_orden )
        REFERENCES orden_jchz ( id_orden ),
    CONSTRAINT cb_np_fk FOREIGN KEY ( numero_pizza )
        REFERENCES ordenes_pizza_jchz ( numero_pizza ),
    CONSTRAINT cb_tb_fk FOREIGN KEY ( id_cobertura )
        REFERENCES tipo_cobertura_jchz ( id_cobertura )
);

--Secuencias

CREATE SEQUENCE vh_seq_jchz INCREMENT BY 1 START WITH 1 MAXVALUE 2000;

CREATE SEQUENCE met_seq_jchz INCREMENT BY 10 START WITH 10 MAXVALUE 2000;

CREATE SEQUENCE cl_seq_jchz INCREMENT BY 1 START WITH 100 MAXVALUE 2000;

CREATE SEQUENCE es_seq_jchz INCREMENT BY 1 START WITH 1 MAXVALUE 2000;

CREATE SEQUENCE ord_seq_jchz INCREMENT BY 1 START WITH 100 MAXVALUE 2000;

CREATE SEQUENCE dcc_seq_jchz INCREMENT BY 1 START WITH 10 MAXVALUE 2000;

CREATE SEQUENCE emp_seq_jchz INCREMENT BY 1 START WITH 10 MAXVALUE 2000;
    
--                                             Insertando Valores     

INSERT INTO tipo_auto_jchz VALUES (
    vh_seq_jchz.NEXTVAL,
    'Moto Estadar'
);

INSERT INTO tipo_auto_jchz VALUES (
    vh_seq_jchz.NEXTVAL,
    'Moto Nueva 2022'
);

INSERT INTO tipo_auto_jchz VALUES (
    vh_seq_jchz.NEXTVAL,
    'Auto Pequeño'
);

INSERT INTO tipo_auto_jchz VALUES (
    vh_seq_jchz.NEXTVAL,
    'Auto Viaje largos'
);

INSERT INTO tipo_auto_jchz VALUES (
    vh_seq_jchz.NEXTVAL,
    'Descompuesto'
);

INSERT INTO vehiculo_jchz VALUES (
    vh_seq_jchz.NEXTVAL,
    1,
    12345
);

INSERT INTO vehiculo_jchz VALUES (
    vh_seq_jchz.NEXTVAL,
    1,
    12346
);

INSERT INTO vehiculo_jchz VALUES (
    vh_seq_jchz.NEXTVAL,
    2,
    12347
);

INSERT INTO vehiculo_jchz VALUES (
    vh_seq_jchz.NEXTVAL,
    3,
    12348
);

INSERT INTO vehiculo_jchz VALUES (
    vh_seq_jchz.NEXTVAL,
    3,
    12342
);

INSERT INTO direccion VALUES (
    dcc_seq_jchz.NEXTVAL,
    'Av del derecho',
    'Guadalupe',
    98614,
    'zac'
);

INSERT INTO direccion VALUES (
    dcc_seq_jchz.NEXTVAL,
    'Tierra y libertad',
    'Guadalupe',
    98611,
    'zac'
);

INSERT INTO direccion VALUES (
    dcc_seq_jchz.NEXTVAL,
    'Villas monasterio',
    'Guadalupe',
    98616,
    'zac'
);

INSERT INTO direccion VALUES (
    dcc_seq_jchz.NEXTVAL,
    'Av México',
    'Zacatecas',
    98600,
    'zac'
);

INSERT INTO direccion VALUES (
    dcc_seq_jchz.NEXTVAL,
    'Calzada Solidaridad',
    'Zacatecas',
    98600,
    'zac'
);

SELECT
    *
FROM
    direccion;

INSERT INTO empleado_pizza_jchz VALUES (
    emp_seq_jchz.NEXTVAL,
    10,
    'Alfred',
    4921129192
);

INSERT INTO empleado_pizza_jchz VALUES (
    emp_seq_jchz.NEXTVAL,
    11,
    'Gabriela ',
    4921129193
);

INSERT INTO empleado_pizza_jchz VALUES (
    emp_seq_jchz.NEXTVAL,
    11,
    'Jorge',
    4921129195
);

INSERT INTO empleado_pizza_jchz VALUES (
    emp_seq_jchz.NEXTVAL,
    10,
    'Frrda',
    4921129196
);

INSERT INTO empleado_pizza_jchz VALUES (
    emp_seq_jchz.NEXTVAL,
    11,
    'Lucia',
    4921129197
);

SELECT
    *
FROM
    empleado_pizza_jchz;

INSERT INTO metodo_pago_jchz VALUES (
    1,
    'Efectivo'
);

INSERT INTO metodo_pago_jchz VALUES (
    2,
    'Tarjeta Debito'
);

INSERT INTO metodo_pago_jchz VALUES (
    3,
    'Tarjeta Credito'
);

INSERT INTO metodo_pago_jchz VALUES (
    4,
    'Transferencia'
);

INSERT INTO metodo_pago_jchz VALUES (
    5,
    'Criptomonedas'
);

SELECT
    *
FROM
    metodo_pago_jchz;

INSERT INTO estatus_jchz VALUES (
    es_seq_jchz.NEXTVAL,
    'En preparacion'
);

INSERT INTO estatus_jchz VALUES (
    es_seq_jchz.NEXTVAL,
    'Ordenando'
);

INSERT INTO estatus_jchz VALUES (
    es_seq_jchz.NEXTVAL,
    'Cancelado'
);

INSERT INTO estatus_jchz VALUES (
    es_seq_jchz.NEXTVAL,
    'Pago rechazado'
);

INSERT INTO estatus_jchz VALUES (
    es_seq_jchz.NEXTVAL,
    'Repartiendo'
);

SELECT
    *
FROM
    estatus_jchz;

INSERT INTO tipo_base_jchz VALUES (
    1,
    50,
    'Peperonni'
);

INSERT INTO tipo_base_jchz VALUES (
    2,
    50,
    'Hawaiana'
);

INSERT INTO tipo_base_jchz VALUES (
    3,
    50,
    'Champiñones'
);

INSERT INTO tipo_base_jchz VALUES (
    4,
    50,
    'Napolitana'
);

INSERT INTO tipo_base_jchz VALUES (
    5,
    50,
    'Queso'
);

SELECT
    *
FROM
    direccion;

INSERT INTO tipo_cobertura_jchz VALUES (
    1,
    70,
    'Normal'
);

INSERT INTO tipo_cobertura_jchz VALUES (
    2,
    70,
    'Con queso'
);

INSERT INTO tipo_cobertura_jchz VALUES (
    3,
    70,
    'Quso con chile'
);

INSERT INTO tipo_cobertura_jchz VALUES (
    4,
    70,
    'Especial'
);

INSERT INTO tipo_cobertura_jchz VALUES (
    5,
    70,
    'Queso con salsa de tomate'
);

SELECT
    *
FROM
    tipo_cobertura_jchz;

INSERT INTO clientes_jchz VALUES (
    cl_seq_jchz.NEXTVAL,
    10,
    1,
    'alfredo',
    4921334733,
    '24/11/2022'
);

INSERT INTO clientes_jchz VALUES (
    cl_seq_jchz.NEXTVAL,
    12,
    1,
    'Jimenes',
    4921334753,
    '24/11/2022'
);

INSERT INTO clientes_jchz VALUES (
    cl_seq_jchz.NEXTVAL,
    12,
    1,
    'Batman',
    4921324733,
    '25/11/2022'
);

INSERT INTO clientes_jchz VALUES (
    cl_seq_jchz.NEXTVAL,
    14,
    1,
    'Diego',
    4921333736,
    '25/11/2022'
);

INSERT INTO clientes_jchz VALUES (
    cl_seq_jchz.NEXTVAL,
    14,
    1,
    'Soule',
    4921334753,
    '25/11/2022'
);

SELECT
    *
FROM
    orden_jchz;

INSERT INTO orden_jchz VALUES (
    ord_seq_jchz.NEXTVAL,
    118,
    215,
    214,
    5,
    6,
    '24/11/2022',
    '24/11/2022',
    299
);

INSERT INTO orden_jchz VALUES (
    ord_seq_jchz.NEXTVAL,
    121,
    217,
    214,
    5,
    6,
    '24/11/2022',
    '24/11/2022',
    299
);

INSERT INTO orden_jchz VALUES (
    ord_seq_jchz.NEXTVAL,
    120,
    217,
    216,
    5,
    6,
    '25/11/2022',
    '25/11/2022',
    399
);

INSERT INTO orden_jchz VALUES (
    ord_seq_jchz.NEXTVAL,
    124,
    215,
    216,
    5,
    6,
    '25/11/2022',
    '25/11/2022',
    599
);

INSERT INTO orden_jchz VALUES (
    ord_seq_jchz.NEXTVAL,
    121,
    218,
    214,
    5,
    6,
    '25/11/2022',
    '25/11/2022',
    99
);

INSERT INTO ordenes_pizza_jchz VALUES (
    100,
    1,
    2
);

INSERT INTO ordenes_pizza_jchz VALUES (
    104,
    2,
    1
);

INSERT INTO ordenes_pizza_jchz VALUES (
    102,
    3,
    3
);

INSERT INTO ordenes_pizza_jchz VALUES (
    106,
    4,
    4
);

INSERT INTO ordenes_pizza_jchz VALUES (
    104,
    5,
    1
);

INSERT INTO ordenes_pizza_jchz VALUES (
    105,
    6,
    5
);

SELECT
    *
FROM
    cobertura_jchz;

INSERT INTO cobertura_jchz VALUES (
    100,
    1,
    1,
    1
);

INSERT INTO cobertura_jchz VALUES (
    106,
    2,
    2,
    2
);

INSERT INTO cobertura_jchz VALUES (
    102,
    3,
    3,
    3
);

INSERT INTO cobertura_jchz VALUES (
    105,
    4,
    4,
    4
);

INSERT INTO cobertura_jchz VALUES (
    104,
    5,
    5,
    5
);
    
-- Consultas 

-- 1 Muestre las combinaciones de las pizzas
SELECT
    tb.descripcion AS cobertura,
    tc.descripcion AS base
FROM
         orden_jchz o
    JOIN ordenes_pizza_jchz  ord ON o.id_orden = ord.id_orden
    JOIN cobertura_jchz      cb ON cb.id_orden = ord.id_orden
    JOIN tipo_base_jchz      tb ON ord.id_base = tb.id_base
    JOIN tipo_cobertura_jchz tc ON tc.id_cobertura = cb.id_cobertura;

-- 2 Mustra los cuales son los empleados que han sido repartidores 

select em.Nombre as Repartidor
    from empleado_pizza_jchz em join orden_jchz o on em.id_empleado = o.id_repartidor;


-- 3 Suma la cobertura y las base e ve la diferencia del precio total
SELECT
    ( tb.precio + tc.precio )                  AS suma_precio,
    ( tb.precio + tc.precio - o.precio_total ) AS diferencia
FROM
         orden_jchz o
    JOIN ordenes_pizza_jchz  ord ON o.id_orden = ord.id_orden
    JOIN cobertura_jchz      cb ON cb.id_orden = ord.id_orden
    JOIN tipo_base_jchz      tb ON ord.id_base = tb.id_base
    JOIN tipo_cobertura_jchz tc ON tc.id_cobertura = cb.id_cobertura;
        
-- 4 Cual es el metodo de pago mas eficiente 
Select m.Descripcion
    from metodo_pago_jchz m join clientes_jchz cl on m.id_metodo = cl.id_metodo
    group by m.descripcion
    having count(cl.id_metodo) =
                            (select max(count(id_metodo)) 
                                    from clientes_jchz 
                                group by id_metodo);
                                
--5 Cual es el vehiculo que más se utiliza
Select ta.descripcion 
        from tipo_auto_jchz ta join vehiculo_jchz v on ta.id_tipo_vehiculo = v.id_tipo_vehiculo
            join orden_jchz o on o.id_vehiculo = v.id_vehiculo
            group by ta.descripcion
        having count(o.id_vehiculo) =  
                        (Select max(count(id_vehiculo))
                                from orden_jchz
                            group by id_vehiculo);
                            
-- 6 El empleado que más pizzas ha entregado
select em.Nombre as Repartidor
    from empleado_pizza_jchz em join orden_jchz o on em.id_empleado = o.id_repartidor
    group by em.nombre
    having count(id_repartidor) =
                                (select max(count(id_repartidor)) 
                                            from orden_jchz
                                        group by id_repartidor);


-- 7 El empleado que más ordenes realizo
select em.Nombre as empleado
    from empleado_pizza_jchz em join orden_jchz o on em.id_empleado = o.id_empleado_orden
    group by em.nombre
    having count(id_empleado_orden) =
                                (select max(count(id_empleado_orden)) 
                                            from orden_jchz
                                        group by id_empleado_orden);
--8 El cliente que mas ha pedido
select cl.Nombre 
        from clientes_jchz cl join orden_jchz o on cl.id_cliente = o.id_cliente
    group by cl.Nombre
        having count(o.id_cliente) =
                                    (Select max(count(id_cliente))
                                            from orden_jchz
                                        group by id_cliente);
-- 9 Ordenes canceladas
Select id_orden from orden_jchz
        where id_estatus = 3;
--10 Cual es el dia con mas ordenes tomadas 
Select orden_tomada
        from orden_jchz
    group by orden_tomada 
    having count(orden_tomada) =
                                (Select max(count(orden_tomada)) 
                                    from orden_jchz group by orden_tomada);
--11 Suma total por dia
Select Orden_tomada as Dia, Sum(precio_total) as "ganacia Total"
        from orden_jchz 
    group by orden_tomada;
--12 Promedio total de ganacias
Select avg(precio_total)
        from orden_jchz;
--13 Ordenes que superan el promedio
select id_orden, precio_total
    from orden_jchz 
    group by id_orden, precio_total
    having precio_total > (Select avg(precio_total)
        from orden_jchz);
--14 Orden que no suprean el promedio
select id_orden, precio_total
    from orden_jchz 
    group by id_orden, precio_total
    having precio_total < (Select avg(precio_total)
        from orden_jchz);
--15 Cual es la cobertura que más piden
Select tc.descripcion as Cobertura
        from tipo_cobertura_jchz tc join cobertura_jchz c on tc.id_cobertura = c.id_cobertura
        group by tc.descripcion
        having count(c.id_cobertura) =
                                    (Select max(count(id_cobertura))
                                        from cobertura_jchz group by id_cobertura);
--16 Menciona quien tomo la orden y quein la llevo por cada cliente
select cl.Nombre as cliente, e.nombre as "Empleado que recibio la orden"
        from clientes_jchz cl join orden_jchz o on cl.id_cliente = o.id_cliente
            join empleado_pizza_jchz e on e.id_empleado = o.id_empleado_orden;
--17 Cuales son las pizzas que pidieron cada uno de los clienyes
select cl.nombre, tb.descripcion as Base, tc.descripcion as Cobertura
    from clientes_jchz cl join orden_jchz o on cl.id_cliente = o.id_cliente
            join ordenes_pizza_jchz op on o.id_orden = op.id_orden 
            join tipo_base_jchz tb on tb.id_base = op.id_base
            Join cobertura_jchz c on c.id_orden = op.id_orden
            Join tipo_cobertura_jchz tc on tc.id_cobertura = c.id_cobertura
        group by cl.nombre, tb.descripcion, tc.descripcion;
--18 Muestra a los clientes y us direcciones
Select cl.Nombre, d.calle || ' en la ciudad de ' || d.ciudad
    from clientes_jchz cl join direccion d on d.id_direccion = cl.id_direccion;
--19 Muestre el tipo de vehiculo y su licencia
select v.id_vehiculo, tv.descripcion, v.numero_licencia
        from vehiculo_jchz v join tipo_auto_jchz tv on tv.id_tipo_vehiculo = v.id_tipo_vehiculo;
--20 Muestre las direcciones que ha ido cada uno de los repartidores
select e.Nombre, d.calle
        from empleado_pizza_jchz e join orden_jchz o on o.id_repartidor = e.id_empleado
                join clientes_jchz cl on cl.id_cliente  = o.id_cliente
                join direccion d on d.id_direccion = cl.id_direccion;
--21 Que vehiculo a usado cada repartidor 
select em.nombre, tv.descripcion 
    from empleado_pizza_jchz em join orden_jchz o on o.id_repartidor = em.id_empleado
            join vehiculo_jchz v on v.id_vehiculo = o.id_vehiculo
            Join tipo_auto_jchz tv on tv.id_tipo_vehiculo = v.id_tipo_vehiculo;
--22 Muestre donde vive cada empleado
Select em.Nombre, d.calle, d.ciudad
    from empleado_pizza_jchz em join direccion d on d.id_direccion = em.id_direccion
        ;
--23 Que direcciones comparten los empleados y los clientes
select d.calle, 'Cliente '|| cl.Nombre ||' y el empleado ' || em.nombre
    from direccion d join clientes_jchz cl on cl.id_direccion = d.id_direccion
            join empleado_pizza_jchz em on em.id_direccion = d.id_direccion;
--24 Muestra la orden mas costosa
Select max(precio_total) as Mas_costosa from orden_jchz;
--25 Menciona quien llevo por cada cliente
select cl.Nombre as cliente, e.nombre as repartidor
        from clientes_jchz cl join orden_jchz o on cl.id_cliente = o.id_cliente
            join empleado_pizza_jchz e on e.id_empleado = o.id_repartidor;