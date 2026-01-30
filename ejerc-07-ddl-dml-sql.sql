
--tarea 7 SQL DML DDL consulta 1
CREATE TABLE facturas (
	id_factura SERIAL NOT NULL,
	rut_comprador varchar (12),
	rut_vendedor varchar(12),
	PRIMARY KEY (id_factura)
);

 CREATE TABLE productos(
    id_producto  SERIAL PRIMARY KEY,
	nombre varchar(255),
	descripcion varchar(255)
);
 
 CREATE TABLE detalle_facturas (
 	 id_detalle SERIAL PRIMARY KEY,
	 id_producto integer NOT NULL,
	 id_factura integer NOT NULL,
	 FOREIGN KEY (id_factura) REFERENCES facturas(id_factura),
	 FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

CREATE TABLE existencias(
	id_existencia SERIAL PRIMARY KEY,
	id_producto integer NOT NULL,
	cantidad integer,
	precio integer,
	pesoKG integer, 
	FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- consulta 2
INSERT INTO productos (nombre, descripcion) VALUES
('Laptop Gamer', 'Laptop de alto rendimiento con tarjeta gráfica dedicada'),
('Mouse Inalámbrico', 'Mouse ergonómico con conexión Bluetooth'),
('Teclado Mecánico', 'Teclado con switches mecánicos y retroiluminación'),
('Monitor 24"', 'Monitor LED Full HD de 24 pulgadas'),
('Auriculares', 'Auriculares con cancelación de ruido'),
('Smartphone X', 'Teléfono inteligente con cámara de 108MP'),
('Impresora Láser', 'Impresora láser en blanco y negro con Wi-Fi'),
('Tablet 10"', 'Tablet con pantalla de 10 pulgadas y Android'),
('Disco Duro SSD 1TB', 'Disco de estado sólido de 1TB'),
('Cámara Web HD', 'Cámara web HD para videollamadas y streaming');


--consulta 3

INSERT INTO existencias (id_producto,cantidad, precio, pesoKG) VALUES
(1, 15, 1200, 2.5),  -- Laptop Gamer
(2, 50, 25, 0.2),    -- Mouse Inalámbrico
(3, 30, 80, 0.8),    -- Teclado Mecánico
(4, 20, 150, 3.0),   -- Monitor 24"
(5, 40, 60, 0.4),    -- Auriculares
(6, 25, 900, 0.3),   -- Smartphone X
(7, 10, 200, 5.0),   -- Impresora Láser
(8, 18, 300, 0.5),   -- Tablet 10"
(9, 22, 120, 0.1),   -- Disco Duro SSD 1TB
(10, 35, 70, 0.2);   -- Cámara Web HD

-- corrigiendo precios
UPDATE existencias SET precio = 500000 WHERE id_producto = 1;
UPDATE existencias SET precio = 2500   WHERE id_producto = 2;
UPDATE existencias SET precio = 10000  WHERE id_producto = 3;
UPDATE existencias SET precio = 30000  WHERE id_producto = 4;
UPDATE existencias SET precio = 12000  WHERE id_producto = 5;
UPDATE existencias SET precio = 100000 WHERE id_producto = 6;
UPDATE existencias SET precio = 80000  WHERE id_producto = 7;
UPDATE existencias SET precio = 150000 WHERE id_producto = 8;
UPDATE existencias SET precio = 80000  WHERE id_producto = 9;
UPDATE existencias SET precio = 12000  WHERE id_producto = 10;

--consulta 4

INSERT INTO facturas (id_factura, rut_comprador, rut_vendedor) VALUES
(1,'102365897','90258456K'),
(2,'102365897','90258666K'),
(3,'182225774','88222111K'),
(4,'112331118','90258456K'),
(5,'173335097','88222111K');

--consulta 5
INSERT INTO detalle_facturas (id_factura, id_producto) VALUES

(1, 1),  -- Laptop Gamer, 2 unidades
(1, 3),  -- Teclado Mecánico, 1 unidad
(1, 5),  -- Auriculares, 4 unidades

-- Fact 2 
(2, 2),  -- Mouse Inalámbrico, 1 unidad
(2, 4),  -- Monitor 24", 2 unidades
(2, 6),  -- Smartphone X, 1 unidad
(2, 7),  -- Impresora Láser, 1 unidad

-- Fact 3 
(3, 1),  -- Laptop Gamer, 1 unidad
(3, 2),  -- Mouse Inalámbrico, 2 unidades
(3, 3),  -- Teclado Mecánico, 1 unidad
(3, 8),  -- Tablet 10", 1 unidad
(3, 9),  -- Disco Duro SSD 1TB, 3 unidades

-- Fact 4 
(4, 5),  -- Auriculares, 2 unidades
(4, 7),  -- Impresora Láser, 1 unidad
(4, 10), -- Cámara Web HD, 1 unidad

-- Fact 5 
(5, 1),  -- Laptop Gamer, 1 unidad
(5, 4),  -- Monitor 24", 1 unidad
(5, 6),  -- Smartphone X, 1 unidad
(5, 9);  -- Disco Duro SSD 1TB, 2 unidades

--consulta 6
UPDATE existencias
SET cantidad = 10;

-- consulta 7
ALTER TABLE facturas
ADD COLUMN fecha DATE;

--consulta 8
UPDATE facturas
SET fecha = CASE id_factura
    WHEN 1 THEN DATE '2026-01-20'
    WHEN 2 THEN DATE '2026-01-21'
    WHEN 3 THEN DATE '2026-01-22'
    WHEN 4 THEN DATE '2026-01-23'
    WHEN 5 THEN DATE '2026-01-24'
END;

--consulta 9
ALTER TABLE existencias
DROP COLUMN pesoKG;

--consulta 10
SELECT f.id_factura,
       p.nombre AS producto,
       e.precio
FROM facturas f
JOIN detalle_facturas df ON f.id_factura = df.id_factura
JOIN productos p ON df.id_producto = p.id_producto
JOIN existencias e ON p.id_producto = e.id_producto
WHERE f.id_factura = 1;

--consulta 11 consulta el valor final de una fact
SELECT f.id_factura,
	SUM(e.precio) AS valor_final
FROM facturas f
JOIN detalle_facturas df ON f.id_factura = df.id_factura
JOIN productos p ON df.id_producto = p.id_producto
join existencias e ON p.id_producto = e.id_producto
WHERE f.id_factura = 1
GROUP BY f.id_factura;

--consulta 12 elimina todos los productos
DELETE FROM detalle_facturas;
DELETE FROM existencias;
DELETE FROM productos;

