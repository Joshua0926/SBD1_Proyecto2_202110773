-- create schema fiusac;
use fiusac;

-- ------------------ Creacion de Tablas ------------------------

-- Crear la tabla Bitacora si no existe
CREATE TABLE IF NOT EXISTS Bitacora (
    id_bitacora INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATETIME,
    descripcion VARCHAR(255),
    tipo VARCHAR(255)
);

-- Crear la tabla Carrera si no existe
CREATE TABLE IF NOT EXISTS Carrera (
    id_carrera INT PRIMARY KEY,
    nombre VARCHAR(20) UNIQUE
);
INSERT IGNORE INTO Carrera (id_carrera, nombre) VALUES (0, 'Área Común');

-- Crear la tabla Estudiante si no existe
CREATE TABLE IF NOT EXISTS Estudiante (
    carnet BIGINT PRIMARY KEY,
    nombres VARCHAR(50),
    apellidos VARCHAR(50),
    fecha_nacimiento DATE,
    correo VARCHAR(100),
    telefono VARCHAR(15),
    direccion VARCHAR(100),
    dpi BIGINT(13),
    id_carrera INT,
    creditos INT,
    fecha_creacion  DATETIME,
    FOREIGN KEY (id_carrera) REFERENCES Carrera(id_carrera)
);

-- Crea la tabla Docente si no existe
CREATE TABLE IF NOT EXISTS Docente (
    id_docente BIGINT PRIMARY KEY,
    nombres VARCHAR(50),
    apellidos VARCHAR(50),
    fecha_nacimiento DATE,
    correo VARCHAR(100),
    telefono VARCHAR(15),
    direccion VARCHAR(100),
    dpi BIGINT(13),
    fecha_creacion DATETIME
);

-- Crear la tabla Curso si no existe
CREATE TABLE IF NOT EXISTS Curso (
    id_curso INT PRIMARY KEY,
    nombre VARCHAR(20),
    creditos_necesarios INT,
    creditos_otorgados INT,
    id_carrera INT,
    obligatorio BOOLEAN,
    FOREIGN KEY (id_carrera) REFERENCES Carrera(id_carrera)
);

-- Crear la tabla Ciclo si no existe
CREATE TABLE IF NOT EXISTS Ciclo (
    id_ciclo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(2) NOT NULL
);

-- Crear la tabla Seccion si no existe
CREATE TABLE IF NOT EXISTS Seccion (
    id_seccion INT AUTO_INCREMENT PRIMARY KEY,
    letra CHAR(1) NOT NULL
);

-- Crear la tabla CursoHabilitado si no existe
CREATE TABLE IF NOT EXISTS CursoHabilitado
(
	id_cursohabilitado INT PRIMARY KEY AUTO_INCREMENT,
    cupomaximo INT,
    id_seccion INT,
    id_docente BIGINT,
    id_ciclo INT,
    id_curso INT,
    asignacion INT DEFAULT 0,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_seccion) REFERENCES Seccion(id_seccion),
    FOREIGN KEY (id_docente) REFERENCES Docente(id_docente),
    FOREIGN KEY (id_ciclo) REFERENCES Ciclo(id_ciclo),
    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso)
);

-- Crear la tabla Horario si no existe
CREATE TABLE IF NOT EXISTS Horario
(
id_horario INT PRIMARY KEY AUTO_INCREMENT,
dia INT,
horario VARCHAR(20)
);

-- Crear la tabla HorarioEnCurso si no existe
CREATE TABLE IF NOT EXISTS HorarioEnCurso
(
	id_cursohabilitado int, 
	id_horario int,
	FOREIGN KEY (id_cursohabilitado) REFERENCES CursoHabilitado(id_cursohabilitado),
    FOREIGN KEY (id_horario) REFERENCES Horario(id_horario)
);

-- Crear la tabla Asigancion si no existe
CREATE TABLE IF NOT EXISTS Asignacion(
id_asignacion INT PRIMARY KEY AUTO_INCREMENT,
asignado BIT,
carnet VARCHAR(255),
id_cursohabilitado INT,
FOREIGN KEY (carnet) REFERENCES Estudiante(carnet),
FOREIGN KEY (id_cursohabilitado) REFERENCES CursoHabilitado(id_cursohabilitado)
);

-- Crear la tabla Nota si no existe
CREATE TABLE IF NOT EXISTS Nota(
id_nota INT PRIMARY KEY AUTO_INCREMENT,
nota INT,
id_asignacion INT,
FOREIGN KEY (id_asignacion) REFERENCES Asignacion(id_asignacion)
);

-- Crear la tabla Acta si no existe
CREATE TABLE IF NOT EXISTS Acta(
	id_acta INT PRIMARY KEY AUTO_INCREMENT,
	fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_cursohabilitado INT,
    FOREIGN KEY (id_cursohabilitado) REFERENCES CursoHabilitado(id_cursohabilitado)
);


-- ------------------- Creación de Triggers ------------------------

-- Crear el trigger de la tabla Carrera
DELIMITER //
CREATE TRIGGER Carrera_Insert_Bitacora
AFTER INSERT ON Carrera FOR EACH ROW
BEGIN
    -- Insertar en la tabla Bitacora
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha agregado un nuevo registro en la tabla Carrera'), 'INSERT');
END;
//
DELIMITER ;

-- Crear el trigger de la tabla Estudiante
DELIMITER //
CREATE TRIGGER Estudiante_Insert_Bitacora
AFTER INSERT ON Estudiante FOR EACH ROW
BEGIN
    -- Insertar en la tabla Bitacora
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha agregado un nuevo registro en la tabla Estudiante'), 'INSERT');
END;
//
DELIMITER ;

-- Crear el trigger de la tabla Docente
DELIMITER //
CREATE TRIGGER Docente_Insert_Bitacora
AFTER INSERT ON Docente FOR EACH ROW
BEGIN
    -- Insertar en la tabla Bitacora
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha agregado un nuevo registro en la tabla Docente'), 'INSERT');
END;
//
DELIMITER ;

-- Crear el trigger de la tabla Curso
DELIMITER //
CREATE TRIGGER Curso_Insert_Bitacora
AFTER INSERT ON Curso FOR EACH ROW
BEGIN
    -- Insertar en la tabla Bitacora
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha agregado un nuevo registro en la tabla Curso'), 'INSERT');
END;
//
DELIMITER ;

-- Crear el trigger de la tabla Ciclo
DELIMITER //
CREATE TRIGGER Ciclo_Insert_Bitacora
AFTER INSERT ON Ciclo FOR EACH ROW
BEGIN
    -- Insertar en la tabla Bitacora
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha agregado un nuevo registro en la tabla Ciclo'), 'INSERT');
END;
//
DELIMITER ;

-- Crear el trigger de la tabla Seccion
DELIMITER //
CREATE TRIGGER Seccion_Insert_Bitacora
AFTER INSERT ON Seccion FOR EACH ROW
BEGIN
    -- Insertar en la tabla Bitacora
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha agregado un nuevo registro en la tabla Seccion'), 'INSERT');
END;
//
DELIMITER ;

-- Crear el trigger de la tabla CursoHabilitado
DELIMITER //
CREATE TRIGGER CursoHabilitado_Insert_Bitacora
AFTER INSERT ON CursoHabilitado FOR EACH ROW
BEGIN
    -- Insertar en la tabla Bitacora
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha agregado un nuevo registro en la tabla CursoHabilitado'), 'INSERT');
END;
//
DELIMITER ;

-- Crear el trigger de la tabla Horario
DELIMITER //
CREATE TRIGGER Horario_Insert_Bitacora
AFTER INSERT ON Horario FOR EACH ROW
BEGIN
    -- Insertar en la tabla Bitacora
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha agregado un nuevo registro en la tabla Horario'), 'INSERT');
END;
//
DELIMITER ;

-- Crear el trigger de la tabla HorarioEnCurso
DELIMITER //
CREATE TRIGGER HorarioEnCurso_Insert_Bitacora
AFTER INSERT ON HorarioEnCurso FOR EACH ROW
BEGIN
    -- Insertar en la tabla Bitacora
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha agregado un nuevo registro en la tabla HorarioEnCurso'), 'INSERT');
END;
//
DELIMITER ;

-- Crear el trigger de la tabla Asignacion
DELIMITER //
CREATE TRIGGER Asignacion_Insert_Bitacora
AFTER INSERT ON Asignacion FOR EACH ROW
BEGIN
    -- Insertar en la tabla Bitacora
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha agregado un nuevo registro en la tabla Asignacion'), 'INSERT');
END;
//
DELIMITER ;

-- Crear el trigger de la tabla Nota
DELIMITER //
CREATE TRIGGER Nota_Insert_Bitacora
AFTER INSERT ON Nota FOR EACH ROW
BEGIN
    -- Insertar en la tabla Bitacora
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha agregado un nuevo registro en la tabla Nota'), 'INSERT');
END;
//
DELIMITER ;

-- Crear el trigger de la tabla Acta
DELIMITER //
CREATE TRIGGER Acta_Insert_Bitacora
AFTER INSERT ON Acta FOR EACH ROW
BEGIN
    -- Insertar en la tabla Bitacora
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha agregado un nuevo registro en la tabla Acta'), 'INSERT');
END;
//
DELIMITER ;


-- --------------- Creación de Procedimientos -----------------------

-- Crear el procedimiento para agregar datos a la tabla Carrera
DELIMITER //
CREATE PROCEDURE crearCarrera(
    IN nombreCarrera VARCHAR(20)
)
BEGIN
	DECLARE nuevo_id INT;
    -- Validar que el nombre contenga solo letras
    IF nombreCarrera REGEXP '^[a-zA-Z ]+$' THEN
        -- Verificar si el nombre ya existe en la tabla Carrera
        IF NOT EXISTS (SELECT 1 FROM Carrera WHERE nombre = nombreCarrera) THEN
            -- Insertar la nueva carrera
            
			SELECT id_carrera INTO nuevo_id FROM Carrera WHERE nombre = nombreCarrera LIMIT 1;
			IF nuevo_id IS NULL THEN
				SELECT MAX(id_carrera) + 1 INTO nuevo_id FROM Carrera;
				IF nuevo_id IS NULL THEN
					SET nuevo_id = 0;
				END IF;
				INSERT INTO Carrera (id_carrera, nombre) VALUES (nuevo_id, nombreCarrera);
			END IF;
        ELSE
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'La carrera ya existe en la tabla Carrera.';
        END IF;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El nombre de la carrera debe contener solo letras y espacios.';
    END IF;
END //
DELIMITER ;

-- Crear el procedimiento para agregar datos a la tabla Estudiante
DELIMITER //
CREATE PROCEDURE registrarEstudiante(
    IN carnet_param BIGINT,
    IN nombres_param VARCHAR(50),
    IN apellidos_param VARCHAR(50),
    IN fecha_nacimiento_param DATE,
    IN correo_param VARCHAR(100),
    IN telefono_param VARCHAR(15),
    IN direccion_param VARCHAR(100),
    IN dpi_param BIGINT(13),
    IN id_carrera_param INT
)
BEGIN
    -- Verificar si el carnet ya existe en la tabla Estudiante
    IF NOT EXISTS (SELECT 1 FROM Estudiante WHERE carnet = carnet_param) THEN
        -- Verificar el formato válido del correo
        IF correo_param REGEXP '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$' THEN
            -- Formatear el teléfono (suponiendo que el código de área es 123)
            SET telefono_param = SUBSTRING(telefono_param, 5);
            
            -- Insertar el estudiante en la tabla Estudiante
            INSERT INTO Estudiante (carnet, nombres, apellidos, fecha_nacimiento, correo, telefono, direccion, dpi, id_carrera, creditos, fecha_creacion)
            VALUES (carnet_param, nombres_param, apellidos_param, fecha_nacimiento_param, correo_param, telefono_param, direccion_param, dpi_param, id_carrera_param, 0, NOW());
        ELSE
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El formato del correo no es válido.';
        END IF;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El carnet ya existe en la tabla Estudiante.';
    END IF;
END;
//
DELIMITER ;

-- Crear el procedimiento para agregar docentes
DELIMITER //

CREATE PROCEDURE registrarDocente(
    IN p_id_docente BIGINT,
    IN p_nombres VARCHAR(50),
    IN p_apellidos VARCHAR(50),
    IN p_fecha_nacimiento DATE,
    IN p_correo VARCHAR(100),
    IN p_telefono VARCHAR(15),
    IN p_direccion VARCHAR(100),
    IN p_dpi BIGINT(13)
)
BEGIN
    -- Verificar el formato válido del correo
    IF p_correo REGEXP '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]{2,4}$' THEN
        -- Formatear el teléfono (suponiendo que el código de área es +123)
            SET p_telefono = SUBSTRING(p_telefono, 5);

        -- Verificar que el id_docente no exista previamente en la tabla
        IF NOT EXISTS (SELECT 1 FROM Docente WHERE id_docente = p_id_docente) THEN
            -- Insertar el nuevo docente en la tabla
            INSERT INTO Docente (id_docente, nombres, apellidos, fecha_nacimiento, correo, telefono, direccion, dpi, fecha_creacion)
            VALUES (p_id_docente, p_nombres, p_apellidos, p_fecha_nacimiento, p_correo, p_telefono, p_direccion, p_dpi, NOW());
        ELSE
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El id_docente ya existe en la tabla Docente.';
        END IF;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El correo no tiene un formato válido.';
    END IF;
END;
//

DELIMITER ;


-- Crear el procedimiento para agregar cursos
DELIMITER //
CREATE PROCEDURE crearCurso(
    IN id_curso INT,
    IN nombre VARCHAR(20),
    IN creditos_necesarios INT,
    IN creditos_otorgados INT,
    IN id_carrera INT,
    IN obligatorio BOOLEAN
)
BEGIN
    -- Verificar que creditos_necesarios sea 0 o un entero positivo
    IF creditos_necesarios < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Los créditos necesarios deben ser 0 o un entero positivo.';
    END IF;

    -- Verificar que creditos_otorgados sea un entero positivo
    IF creditos_otorgados <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Los créditos otorgados deben ser un entero positivo.';
    END IF;

    -- Verificar que obligatorio sea 0 o 1
    IF obligatorio NOT IN (0, 1) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El valor de "obligatorio" debe ser 0 o 1.';
    END IF;

    -- Insertar el nuevo curso en la tabla
    INSERT INTO Curso (id_curso, nombre, creditos_necesarios, creditos_otorgados, id_carrera, obligatorio)
    VALUES (id_curso, nombre, creditos_necesarios, creditos_otorgados, id_carrera, obligatorio);
END;
//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE habilitarCurso(
    IN id_curso INT,
    IN nombre_ciclo VARCHAR(2),
    IN id_docente bigint,
    IN cupomaximo INT,
    IN nuevo_letra CHAR(1)
)
BEGIN
    DECLARE seccion_id INT;
    DECLARE ciclo_id INT;
    SELECT id_seccion INTO seccion_id FROM Seccion WHERE letra = nuevo_letra;
    IF seccion_id IS NULL THEN
        INSERT INTO Seccion (letra) VALUES (nuevo_letra);
        SET seccion_id = LAST_INSERT_ID();
    END IF;
    SELECT id_ciclo INTO ciclo_id FROM Ciclo WHERE nombre = nombre_ciclo;
    IF ciclo_id IS NULL THEN
        INSERT INTO Ciclo (nombre) VALUES (nombre_ciclo);
        SET ciclo_id = LAST_INSERT_ID();
    END IF;
    INSERT INTO cursohabilitado (
    cupomaximo, 
    id_seccion, 
    id_docente,
    id_curso,
    id_ciclo
    ) 
    VALUES (
    cupomaximo, 
    seccion_id, 
    id_docente, 
    id_curso,
    ciclo_id
    );
END;
//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE agregarHorario(
    IN nuevo_id_cursohabilitado INT,
    IN nuevo_dia INT,
    IN nuevo_horario VARCHAR(20)
)
BEGIN
    DECLARE nuevo_id_horario INT;
    IF EXISTS (SELECT 1 FROM CursoHabilitado WHERE id_cursohabilitado = nuevo_id_cursohabilitado) THEN
        IF NOT EXISTS (SELECT 1 FROM Horario WHERE dia = nuevo_dia AND horario = nuevo_horario) THEN
            INSERT INTO Horario (
            dia, 
            horario
            ) 
            VALUES (
            nuevo_dia, 
            nuevo_horario
            );
            SET nuevo_id_horario = LAST_INSERT_ID();
        ELSE
            SELECT id_horario INTO nuevo_id_horario FROM Horario WHERE dia = nuevo_dia AND horario = nuevo_horario;
        END IF;
        INSERT INTO HorarioEnCurso(
        id_cursohabilitado, 
        id_horario
        ) 
        VALUES(
        nuevo_id_cursohabilitado, 
        nuevo_id_horario
        );
    END IF;
END;
//
DELIMITER ;

CALL crearCarrera('Civil');
CALL crearCarrera('Mecanica Industrial');
CALL crearCarrera('Industrial');
CALL crearCarrera('Sistemas');
CALL crearCarrera('Mecanica');

CALL registrarEstudiante(202300002,'María','Gómez','1998-08-22','maria@example.com','+50225067895','456 Calle Secundaria',9876543210987,2);
CALL registrarEstudiante(202300001,'Jose','Carrillo','2002-10-16','jose@gmail.com','+50245897463','Ruta a Escuintla km 12',2997536980101,1);

CALL registrarDocente(200200001,'Javier','Guzmán','1990-01-31','edu@gmail.com',+50278693541,'Antigua Guatemala',2997859611101);
 
CALL crearCurso(101, 'Matemática Básica 1', 0, 7, 0,1);
CALL crearCurso(102, 'Matemática Básica 2', 0, 7, 0,1);

CALL habilitarCurso(101, '1S', 200200001, 25, 'A');
CALL habilitarCurso(101, '1S', 200200001, 25, 'C');

CALL agregarHorario(2, 4, '9:00-10:40');
call habilitarCurso(789,'VD',202100121,60,'A');
call crearCurso(789, 'Administ', 5, 4, 1, 0);
call registrarDocente(202100121,'Pablo David', 'Osorio Tally', '2003-09-26', 'joshuaosoriotally@gmail.com', '+50250367150',  '7av 14-74 zona1', '3065420560401')