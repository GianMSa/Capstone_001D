CREATE TABLE pedidos (
    id BIGINT PRIMARY KEY,
    descripcion VARCHAR(255) NOT NULL,
    fecha_entrega TIMESTAMP NOT NULL,
    estado_pedido_fk BIGINT NOT NULL,
    sucursal_fk BIGINT NOT NULL,
    personal_entrega_fk BIGINT NOT NULL,
    usuario_fk BIGINT NOT NULL
);

CREATE TABLE detalle_pedido (
    id BIGINT PRIMARY KEY,
    cantidad NUMERIC NOT NULL,
    descripcion VARCHAR(255),
    productos_pedido_fk BIGINT NOT NULL,
    pedidos_id BIGINT NOT NULL
);

CREATE TABLE productos (
    id_prodc BIGINT PRIMARY KEY,
    nombre_prodc VARCHAR(255) NOT NULL,
    descripcion_prodc VARCHAR(255),
    precio NUMERIC NOT NULL,
    codigo_interno VARCHAR(255) NOT NULL,
    fecha_creacion TIMESTAMP NOT NULL,
    marca_fk BIGINT NOT NULL,
    categoria_fk BIGINT NOT NULL
);

CREATE TABLE categoria (
    id BIGINT PRIMARY KEY,
    nombre VARCHAR(255),
    descripcion VARCHAR(255)
);

CREATE TABLE sucursal (
    id BIGINT PRIMARY KEY,
    nombre_sucursal VARCHAR(255),
    direccion VARCHAR(255),
    descripcion VARCHAR(255),
    stock_prodc NUMERIC NOT NULL,
    bodega_fk BIGINT
);

CREATE TABLE marca (
    id_mprod BIGINT PRIMARY KEY,
    nombre_mprod VARCHAR(255) NOT NULL
);

CREATE TABLE proveedor (
    id_provd BIGINT PRIMARY KEY,
    nombres_provd VARCHAR(255) NOT NULL,
    direccion_provd VARCHAR(255) NOT NULL,
    correo VARCHAR(255) NOT NULL,
    razon_social VARCHAR(255) NOT NULL,
    rut_empresa NUMERIC
);

CREATE TABLE estado_pedido (
    id_estped BIGINT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion VARCHAR(255)
);

CREATE TABLE bodega (
    id_bdg BIGINT PRIMARY KEY,
    nombre_bdg VARCHAR(255) NOT NULL,
    direccion VARCHAR(255) NOT NULL
);

CREATE TABLE usuario (
    id_us BIGINT PRIMARY KEY,
    nombre_usuario VARCHAR(255) NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    correo VARCHAR(255) NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    bodeg_fk BIGINT NOT NULL,
    sucursal_fk BIGINT NOT NULL,
    rol_fk BIGINT NOT NULL
);

CREATE TABLE rol (
    id_rol BIGINT PRIMARY KEY,
    nombre_rol VARCHAR(255) NOT NULL
);

CREATE TABLE notificacion (
    id_ntf BIGINT PRIMARY KEY,
    nombre_ntf VARCHAR(255) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    usuario_fk BIGINT,
    pedido_fk BIGINT,
    fecha_hora_ntd TIMESTAMP
);

CREATE TABLE historial (
    id_hst BIGINT PRIMARY KEY,
    fecha TIMESTAMP NOT NULL,
    usuario_fk BIGINT,
    pedidos_fk BIGINT
);

CREATE TABLE personal_entrega (
    id_psn BIGINT PRIMARY KEY,
    nombre_psn VARCHAR(255) NOT NULL,
    descripcion VARCHAR(255) NOT NULL
);

CREATE TABLE mov_inventario (
    id_mvin BIGINT PRIMARY KEY,
    cantidad INTEGER NOT NULL,
    fecha TIMESTAMP NOT NULL,
    productos_fk BIGINT NOT NULL,
    usuario_fk BIGINT NOT NULL
);

CREATE TABLE stock (
    id_stock BIGINT PRIMARY KEY,
    stock NUMERIC NOT NULL,
    bodega_fk BIGINT NOT NULL,
    productos_fk BIGINT NOT NULL,
    sucursal_fk BIGINT NOT NULL,
    proveedor_fk BIGINT NOT NULL
);

CREATE TABLE permisos (
    id BIGINT PRIMARY KEY,
    modulo_fk BIGINT NOT NULL,
    usuario_fk BIGINT NOT NULL,
    rol_fk BIGINT NOT NULL
);

CREATE TABLE modulos (
    id BIGINT PRIMARY KEY,
    descripcion VARCHAR(255) NOT NULL
);

CREATE TABLE informe (
    id_informe BIGINT PRIMARY KEY,
    titulo VARCHAR(255),
    descripcion VARCHAR(255),
    modulo_origen VARCHAR(255),
    contenido VARCHAR(255),
    archivo_url VARCHAR(255),
    fecha_generado TIMESTAMP,
    usuario_fk BIGINT,
    pedidos_fk BIGINT,
    productos_fk BIGINT,
    empleados_fk BIGINT
);

CREATE TABLE informe_pedidos (
    informe_pedidos_fk VARCHAR(36),
    pedidos_id BIGINT NOT NULL
);

CREATE TABLE informe_productos (
    informe_productos_fk VARCHAR(36),
    productos_id_prodc BIGINT NOT NULL
);

CREATE TABLE informe_usuario (
    informe_empleados_fk VARCHAR(36),
    usuario_id_us BIGINT NOT NULL
);

-- Foreign Keys
ALTER TABLE pedidos ADD FOREIGN KEY (estado_pedido_fk) REFERENCES estado_pedido(id_estped);
ALTER TABLE pedidos ADD FOREIGN KEY (sucursal_fk) REFERENCES sucursal(id);
ALTER TABLE pedidos ADD FOREIGN KEY (personal_entrega_fk) REFERENCES personal_entrega(id_psn);
ALTER TABLE pedidos ADD FOREIGN KEY (usuario_fk) REFERENCES usuario(id_us);

ALTER TABLE detalle_pedido ADD FOREIGN KEY (productos_pedido_fk) REFERENCES productos(id_prodc);
ALTER TABLE detalle_pedido ADD FOREIGN KEY (pedidos_id) REFERENCES pedidos(id);

ALTER TABLE productos ADD FOREIGN KEY (marca_fk) REFERENCES marca(id_mprod);
ALTER TABLE productos ADD FOREIGN KEY (categoria_fk) REFERENCES categoria(id);

ALTER TABLE sucursal ADD FOREIGN KEY (bodega_fk) REFERENCES bodega(id_bdg);

ALTER TABLE usuario ADD FOREIGN KEY (bodeg_fk) REFERENCES bodega(id_bdg);
ALTER TABLE usuario ADD FOREIGN KEY (sucursal_fk) REFERENCES sucursal(id);
ALTER TABLE usuario ADD FOREIGN KEY (rol_fk) REFERENCES rol(id_rol);

ALTER TABLE notificacion ADD FOREIGN KEY (usuario_fk) REFERENCES usuario(id_us);
ALTER TABLE notificacion ADD FOREIGN KEY (pedido_fk) REFERENCES pedidos(id);

ALTER TABLE historial ADD FOREIGN KEY (usuario_fk) REFERENCES usuario(id_us);
ALTER TABLE historial ADD FOREIGN KEY (pedidos_fk) REFERENCES pedidos(id);

ALTER TABLE mov_inventario ADD FOREIGN KEY (productos_fk) REFERENCES productos(id_prodc);
ALTER TABLE mov_inventario ADD FOREIGN KEY (usuario_fk) REFERENCES usuario(id_us);

ALTER TABLE stock ADD FOREIGN KEY (bodega_fk) REFERENCES bodega(id_bdg);
ALTER TABLE stock ADD FOREIGN KEY (productos_fk) REFERENCES productos(id_prodc);
ALTER TABLE stock ADD FOREIGN KEY (sucursal_fk) REFERENCES sucursal(id);
ALTER TABLE stock ADD FOREIGN KEY (proveedor_fk) REFERENCES proveedor(id_provd);

ALTER TABLE permisos ADD FOREIGN KEY (modulo_fk) REFERENCES modulos(id);
ALTER TABLE permisos ADD FOREIGN KEY (usuario_fk) REFERENCES usuario(id_us);
ALTER TABLE permisos ADD FOREIGN KEY (rol_fk) REFERENCES rol(id_rol);

ALTER TABLE informe ADD FOREIGN KEY (usuario_fk) REFERENCES usuario(id_us);

ALTER TABLE informe_pedidos ADD FOREIGN KEY (pedidos_id) REFERENCES pedidos(id);
ALTER TABLE informe_productos ADD FOREIGN KEY (productos_id_prodc) REFERENCES productos(id_prodc);
ALTER TABLE informe_usuario ADD FOREIGN KEY (usuario_id_us) REFERENCES usuario(id_us);
