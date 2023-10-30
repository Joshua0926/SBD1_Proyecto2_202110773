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
    nombre VARCHAR(30) UNIQUE
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
    nombre VARCHAR(40),
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
    notas INT DEFAULT 0,
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
carnet BIGINT,
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

-- ------------------- Triggers de INSERT ------------------------

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

-- --------------- Triggeres de UPDATE ---------------------------

-- Crear el trigger de la tabla Carrera UPDATE
DELIMITER //
CREATE TRIGGER Carrera_Update_Bitacora
AFTER UPDATE ON Carrera FOR EACH ROW
BEGIN
    -- Insertar en la tabla Bitacora
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha actualizado un nuevo registro en la tabla Carrera'), 'UPDATE');
END;
//
DELIMITER ;

DELIMITER //
-- Trigger para la tabla Asignacion
CREATE TRIGGER Asignacion_Update_Bitacora
AFTER UPDATE ON Asignacion FOR EACH ROW
BEGIN
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha actualizado un registro en la tabla Asignacion'), 'UPDATE');
END;
//
DELIMITER ;

DELIMITER //
-- Trigger para la tabla Acta
CREATE TRIGGER Acta_Update_Bitacora
AFTER UPDATE ON Acta FOR EACH ROW
BEGIN
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha actualizado un registro en la tabla Acta'), 'UPDATE');
END;
//
DELIMITER ;

DELIMITER //
-- Trigger para la tabla Ciclo
CREATE TRIGGER Ciclo_Update_Bitacora
AFTER UPDATE ON Ciclo FOR EACH ROW
BEGIN
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha actualizado un registro en la tabla Ciclo'), 'UPDATE');
END;
//
DELIMITER ;

DELIMITER //
-- Trigger para la tabla Curso
CREATE TRIGGER Curso_Update_Bitacora
AFTER UPDATE ON Curso FOR EACH ROW
BEGIN
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha actualizado un registro en la tabla Curso'), 'UPDATE');
END;
//
DELIMITER ;

DELIMITER //
-- Trigger para la tabla CursoHabilitado
CREATE TRIGGER CursoHabilitado_Update_Bitacora
AFTER UPDATE ON CursoHabilitado FOR EACH ROW
BEGIN
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha actualizado un registro en la tabla CursoHabilitado'), 'UPDATE');
END;
//
DELIMITER ;

DELIMITER //
-- Trigger para la tabla Docente
CREATE TRIGGER Docente_Update_Bitacora
AFTER UPDATE ON Docente FOR EACH ROW
BEGIN
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha actualizado un registro en la tabla Docente'), 'UPDATE');
END;
//
DELIMITER ;

DELIMITER //
-- Trigger para la tabla Estudiante
CREATE TRIGGER Estudiante_Update_Bitacora
AFTER UPDATE ON Estudiante FOR EACH ROW
BEGIN
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha actualizado un registro en la tabla Estudiante'), 'UPDATE');
END;
//
DELIMITER ;

DELIMITER //
-- Trigger para la tabla Horario
CREATE TRIGGER Horario_Update_Bitacora
AFTER UPDATE ON Horario FOR EACH ROW
BEGIN
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha actualizado un registro en la tabla Horario'), 'UPDATE');
END;
//
DELIMITER ;

DELIMITER //
-- Trigger para la tabla HorarioEnCurso
CREATE TRIGGER HorarioEnCurso_Update_Bitacora
AFTER UPDATE ON HorarioEnCurso FOR EACH ROW
BEGIN
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha actualizado un registro en la tabla HorarioEnCurso'), 'UPDATE');
END;
//
DELIMITER ;

DELIMITER //
-- Trigger para la tabla Nota
CREATE TRIGGER Nota_Update_Bitacora
AFTER UPDATE ON Nota FOR EACH ROW
BEGIN
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha actualizado un registro en la tabla Nota'), 'UPDATE');
END;
//
DELIMITER ;

DELIMITER //
-- Trigger para la tabla Seccion
CREATE TRIGGER Seccion_Update_Bitacora
AFTER UPDATE ON Seccion FOR EACH ROW
BEGIN
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha actualizado un registro en la tabla Seccion'), 'UPDATE');
END;
//
DELIMITER ;

-- --------------- Triggeres de DELETE ---------------------------

-- Crear el trigger de la tabla Carrera DELETE
DELIMITER //
CREATE TRIGGER Carrera_Delete_Bitacora
AFTER DELETE ON Carrera FOR EACH ROW
BEGIN
    -- Insertar en la tabla Bitacora
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha eliminado un nuevo registro en la tabla Carrera'), 'DELETE');
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER Asignacion_Delete_Bitacora
AFTER DELETE ON Asignacion FOR EACH ROW
BEGIN
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha eliminado un registro en la tabla Asignacion'), 'DELETE');
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER Acta_Delete_Bitacora
AFTER DELETE ON Acta FOR EACH ROW
BEGIN
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha eliminado un registro en la tabla Acta'), 'DELETE');
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER Ciclo_Delete_Bitacora
AFTER DELETE ON Ciclo FOR EACH ROW
BEGIN
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha eliminado un registro en la tabla Ciclo'), 'DELETE');
END;
//
DELIMITER ;


DELIMITER //
CREATE TRIGGER Curso_Delete_Bitacora
AFTER DELETE ON Curso FOR EACH ROW
BEGIN
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha eliminado un registro en la tabla Curso'), 'DELETE');
END;
//
DELIMITER ;


DELIMITER //
CREATE TRIGGER CursoHabilitado_Delete_Bitacora
AFTER DELETE ON CursoHabilitado FOR EACH ROW
BEGIN
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha eliminado un registro en la tabla CursoHabilitado'), 'DELETE');
END;
//
DELIMITER ;


DELIMITER //
CREATE TRIGGER Docente_Delete_Bitacora
AFTER DELETE ON Docente FOR EACH ROW
BEGIN
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha eliminado un registro en la tabla Docente'), 'DELETE');
END;
//
DELIMITER ;


DELIMITER //
CREATE TRIGGER Estudiante_Delete_Bitacora
AFTER DELETE ON Estudiante FOR EACH ROW
BEGIN
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha eliminado un registro en la tabla Estudiante'), 'DELETE');
END;
//
DELIMITER ;


DELIMITER //
CREATE TRIGGER Horario_Delete_Bitacora
AFTER DELETE ON Horario FOR EACH ROW
BEGIN
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha eliminado un registro en la tabla Horario'), 'DELETE');
END;
//
DELIMITER ;


DELIMITER //
CREATE TRIGGER HorarioEnCurso_Delete_Bitacora
AFTER DELETE ON HorarioEnCurso FOR EACH ROW
BEGIN
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha eliminado un registro en la tabla HorarioEnCurso'), 'DELETE');
END;
//
DELIMITER ;


DELIMITER //
CREATE TRIGGER Nota_Delete_Bitacora
AFTER DELETE ON Nota FOR EACH ROW
BEGIN
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha eliminado un registro en la tabla Nota'), 'DELETE');
END;
//
DELIMITER ;


DELIMITER //
CREATE TRIGGER Seccion_Delete_Bitacora
AFTER DELETE ON Seccion FOR EACH ROW
BEGIN
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha eliminado un registro en la tabla Seccion'), 'DELETE');
END;
//
DELIMITER ;



-- --------------- Creación de Funciones ---------------------------

DELIMITER //
CREATE FUNCTION ValidarValoresPermitidos(valor VARCHAR(2)) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE resultado BOOLEAN DEFAULT FALSE;
    IF valor IN ('1S', '2S', 'VJ', 'VD') THEN
        SET resultado = TRUE;
    END IF;
    RETURN resultado;
END;
//
DELIMITER ;

DELIMITER //
CREATE FUNCTION EsLetraAZ(caracter CHAR(1))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE esLetra BOOLEAN;
    SET esLetra = FALSE;
    IF (ASCII(caracter) BETWEEN ASCII('A') AND ASCII('Z') AND caracter NOT LIKE 'Ñ') THEN
        SET esLetra = TRUE;
    END IF;

    RETURN esLetra;
END;
//
DELIMITER ;

DELIMITER //
CREATE FUNCTION EsSoloLetras(frase VARCHAR(255)) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE i INT;
    DECLARE len INT;
    SET i = 1;
    SET len = LENGTH(frase);
    WHILE i <= len DO
        IF NOT (SUBSTRING(frase, i, 1) REGEXP '^[A-Za-zÁÉÍÓÚÜáéíóíü ]$') THEN
            RETURN FALSE; 
        END IF;
        SET i = i + 1;
    END WHILE;
    RETURN TRUE;
END;
//
DELIMITER ;


DELIMITER //
CREATE FUNCTION EsEnteroPositivo(valor INT) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE es_valido BOOLEAN DEFAULT FALSE;
    IF valor >= 0 AND valor = FLOOR(valor) THEN
        SET es_valido = TRUE;
    END IF;
    RETURN es_valido;
END;
//
DELIMITER ;


DELIMITER //
CREATE FUNCTION VerificarDia(numero INT) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE es_valido BOOLEAN DEFAULT FALSE;
    IF numero >= 1 AND numero <= 7 THEN
        SET es_valido = TRUE;
    END IF;
    RETURN es_valido;
END;
//
DELIMITER ;

-- --------------- Creación de Procedimientos -----------------------

-- Crear el procedimiento para agregar datos a la tabla Carrera
DELIMITER //
CREATE PROCEDURE crearCarrera(
    IN nombreCarrera VARCHAR(30)
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
    IN fecha_nacimiento_param VARCHAR(10),
    IN correo_param VARCHAR(100),
    IN telefono_param VARCHAR(15),
    IN direccion_param VARCHAR(100),
    IN dpi_param BIGINT(13),
    IN id_carrera_param INT
)
BEGIN
	-- Convertir la fecha de nacimiento al formato Y-m-d
    SET fecha_nacimiento_param = STR_TO_DATE(fecha_nacimiento_param, '%d-%m-%Y');
    -- Verificar si el carnet ya existe en la tabla Estudiante
    IF NOT EXISTS (SELECT 1 FROM Estudiante WHERE carnet = carnet_param) THEN
        -- Verificar el formato válido del correo
        IF correo_param REGEXP '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$' THEN
            -- Formatear el teléfono (suponiendo que el código de área es 123)
            -- SET telefono_param = SUBSTRING(telefono_param, 5);
            
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
    IN p_nombres VARCHAR(50),
    IN p_apellidos VARCHAR(50),
    IN p_fecha_nacimiento VARCHAR(10),
    IN p_correo VARCHAR(100),
    IN p_telefono VARCHAR(15),
    IN p_direccion VARCHAR(100),
    IN p_dpi BIGINT(13),
    IN p_id_docente BIGINT
)
BEGIN
	-- Convertir la fecha de nacimiento al formato Y-m-d
    SET p_fecha_nacimiento = STR_TO_DATE(p_fecha_nacimiento, '%d-%m-%Y');
    -- Verificar el formato válido del correo
    IF p_correo REGEXP '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]{2,4}$' THEN
        -- Formatear el teléfono (suponiendo que el código de área es +123)
            -- SET p_telefono = SUBSTRING(p_telefono, 5);

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
    IN nombre VARCHAR(40),
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

-- Crear el procedimiento para habilitar curso
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

-- Crear el procedimiento para agregar horario
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

-- Crear el procedimiento para asignar estudiantes a cursos
DELIMITER //
CREATE PROCEDURE asignarCurso(
    IN nuevo_id_curso INT,
    IN nuevo_ciclo VARCHAR(2),
    IN nuevo_seccion CHAR(1),
    IN nuevo_id_estudiante BIGINT
)
BEGIN
    DECLARE import_creditos INT;
    DECLARE import_id_carrera_estudiante INT;
    DECLARE import_id_carrera_curso INT;
    DECLARE import_id_seccion INT;
    DECLARE import_cupomaximo INT;
    DECLARE import_asignacion INT;
    DECLARE import_cursohabilitado INT;
    DECLARE import_id_ciclo INT;
    SELECT creditos, id_carrera INTO import_creditos, import_id_carrera_estudiante FROM Estudiante WHERE carnet = nuevo_id_estudiante;
    SELECT id_carrera INTO import_id_carrera_curso FROM Curso WHERE id_curso = nuevo_id_curso;
    SELECT id_seccion INTO import_id_seccion FROM Seccion WHERE letra = nuevo_seccion;
    SELECT id_ciclo INTO import_id_ciclo FROM Ciclo WHERE nombre = nuevo_ciclo;
    SELECT cupomaximo, asignacion, id_cursohabilitado INTO import_cupomaximo, import_asignacion, import_cursohabilitado FROM CursoHabilitado WHERE id_curso = nuevo_id_curso AND id_seccion = import_id_seccion AND id_ciclo = import_id_ciclo;
    IF NOT EXISTS (SELECT 1 FROM Asignacion WHERE carnet = nuevo_id_estudiante AND id_cursohabilitado = import_cursohabilitado) THEN
        IF import_id_carrera_curso = import_id_carrera_estudiante OR import_id_carrera_curso = 0 THEN
            IF (SELECT creditos_necesarios FROM Curso WHERE id_curso = nuevo_id_curso) <= import_creditos THEN
                IF EXISTS (SELECT 1 FROM CursoHabilitado WHERE id_curso = nuevo_id_curso AND id_seccion = import_id_seccion AND id_ciclo = import_id_ciclo) THEN
                    IF import_cupomaximo > import_asignacion THEN
                        INSERT INTO Asignacion (
                            asignado, 
                            carnet,
                            id_cursohabilitado
                        ) 
                        VALUES (
                            1, 
                            nuevo_id_estudiante,
                            import_cursohabilitado
                        );
                        UPDATE CursoHabilitado SET asignacion = asignacion + 1 WHERE id_cursohabilitado = import_cursohabilitado;
                    ELSE
                        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Se ha alcanzado el cupo máximo';
                    END IF;
                ELSE
                    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No existe la sección seleccionada';
                END IF;
            ELSE
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No tienes los créditos suficientes';
            END IF;
        ELSE
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El curso no pertenece a tu carrera';
        END IF;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ya te has asignado previamente al curso';
    END IF;
END;
//
DELIMITER ;

-- Crear el procedimiento para desasignar estudiantes a cursos
DELIMITER //
CREATE PROCEDURE desasignarCurso(
    IN nuevo_id_curso INT,
    IN nuevo_ciclo VARCHAR(2),
    IN nuevo_seccion CHAR(1),
    IN nuevo_id_estudiante BIGINT
)
BEGIN
    DECLARE import_id_seccion INT;
    DECLARE import_asignacion INT;
    DECLARE import_cursohabilitado INT;
    DECLARE import_id_ciclo INT;
    SELECT id_seccion INTO import_id_seccion FROM Seccion WHERE letra = nuevo_seccion;
    SELECT id_ciclo INTO import_id_ciclo FROM Ciclo WHERE nombre = nuevo_ciclo;
    SELECT id_cursohabilitado INTO import_cursohabilitado FROM CursoHabilitado WHERE id_curso = nuevo_id_curso AND id_seccion = import_id_seccion AND id_ciclo = import_id_ciclo;
    SELECT id_asignacion INTO import_asignacion FROM Asignacion WHERE carnet = nuevo_id_estudiante AND id_cursohabilitado = import_cursohabilitado AND asignado=1;
    IF EXISTS (SELECT 1 FROM Asignacion WHERE carnet = nuevo_id_estudiante AND id_cursohabilitado = import_cursohabilitado AND asignado=1) THEN
                        UPDATE Asignacion SET asignado = 0 WHERE id_asignacion = import_asignacion;
                        UPDATE CursoHabilitado SET asignacion = asignacion - 1 WHERE id_cursohabilitado = import_cursohabilitado;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No existe la asignación seleccionada';
    END IF;
END;
//
DELIMITER ;


-- Crear el procedimiento para ingresar notas
DELIMITER //
CREATE PROCEDURE ingresarNota(
    IN nuevo_id_curso INT,
    IN nuevo_ciclo VARCHAR(2),
    IN nuevo_seccion CHAR(1),
    IN nuevo_id_estudiante BIGINT,
    IN nuevo_nota INT
)
BEGIN
    DECLARE import_id_seccion INT;
    DECLARE import_asignacion INT;
    DECLARE import_cursohabilitado INT;
    DECLARE import_id_ciclo INT;
    DECLARE import_creditos INT;
    IF NOT ValidarValoresPermitidos(nuevo_ciclo) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nombre de ciclo no válido';
    END IF;
    SET nuevo_seccion = UPPER(nuevo_seccion);
	IF NOT EsLetraAZ(nuevo_seccion) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Se ha ingresado un caracter diferente a una letra';
    END IF;
    IF NOT EsEnteroPositivo(nuevo_nota) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El numero que se ha ingresado es incorrecto';
    END IF;
    SET nuevo_nota = ROUND(nuevo_nota,0);
    SELECT creditos_otorgados INTO import_creditos FROM Curso WHERE id_curso = nuevo_id_curso;
    SELECT id_seccion INTO import_id_seccion FROM Seccion WHERE letra = nuevo_seccion;
    SELECT id_ciclo INTO import_id_ciclo FROM Ciclo WHERE nombre = nuevo_ciclo;
    SELECT id_cursohabilitado INTO import_cursohabilitado FROM CursoHabilitado WHERE id_curso = nuevo_id_curso AND id_seccion = import_id_seccion AND id_ciclo = import_id_ciclo;
    SELECT id_asignacion INTO import_asignacion FROM Asignacion WHERE carnet = nuevo_id_estudiante AND id_cursohabilitado = import_cursohabilitado AND asignado=1;
    IF EXISTS (SELECT 1 FROM Asignacion WHERE carnet = nuevo_id_estudiante AND id_cursohabilitado = import_cursohabilitado AND asignado=1) THEN
		IF NOT EXISTS (SELECT 1 FROM Nota WHERE id_asignacion = import_asignacion) THEN
			INSERT INTO Nota(
			nota,
			id_asignacion
			) 
			VALUES (
			nuevo_nota,
			import_asignacion
			);
			IF nuevo_nota >= 61 THEN
				UPDATE Estudiante SET creditos = creditos + import_creditos WHERE carnet = nuevo_id_estudiante;
			END IF;
            UPDATE CursoHabilitado SET notas = notas + 1 WHERE id_cursohabilitado = import_cursohabilitado;
		ELSE
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ya se ha ingresado la nota a este estudiante';
		END IF;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El estudiante no tiene asignado el curso F';
    END IF;
END;
//
DELIMITER ;																									

-- Crear el procedimiento para generar acta
DELIMITER //
CREATE PROCEDURE generarActa(
    IN nuevo_id_curso INT,
    IN nuevo_ciclo VARCHAR(2),
    IN nuevo_seccion CHAR(1)
)
BEGIN
    DECLARE import_id_seccion INT;
    DECLARE import_cursohabilitado INT;
    DECLARE import_id_ciclo INT;
    DECLARE import_notas INT;
    DECLARE import_asignado INT;
    IF NOT ValidarValoresPermitidos(nuevo_ciclo) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nombre de ciclo no válido';
    END IF;
    SET nuevo_seccion = UPPER(nuevo_seccion);
	IF NOT EsLetraAZ(nuevo_seccion) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Se ha ingresado un caracter diferente a una letra';
    END IF;
    SELECT id_seccion INTO import_id_seccion FROM Seccion WHERE letra = nuevo_seccion;
    SELECT id_ciclo INTO import_id_ciclo FROM Ciclo WHERE nombre = nuevo_ciclo;
    SELECT id_cursohabilitado, notas, asignacion INTO import_cursohabilitado, import_notas, import_asignado FROM CursoHabilitado WHERE id_curso = nuevo_id_curso AND id_seccion = import_id_seccion AND id_ciclo = import_id_ciclo;
    IF import_notas = import_asignado THEN
			INSERT INTO Acta (
            id_cursohabilitado
            )
            VALUES (
            import_cursohabilitado
            );
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se ha ingresado las notas de todos los estudiantes';
    END IF;
END;
//
DELIMITER ;

-- --------------- Creación de Procedimientos de Procesamiento de Datos ---------------------------
-- Consultar Pensum
DELIMITER //
CREATE PROCEDURE consultaPensum(IN codigo_carrera INT)
BEGIN
    IF NOT EsEnteroPositivo(codigo_carrera) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se ha ingresado el código de la carrera correctamente';
    END IF;

    SELECT 
        id_curso AS IdCurso, 
        nombre AS Nombre, 
        CASE 
            WHEN obligatorio = 1 THEN 'Si' 
            WHEN obligatorio = 0 THEN 'No' 
        END AS Obligatorio, 
        creditos_necesarios AS CreditosNecesarios
    FROM Curso
    WHERE id_carrera = 0 OR id_carrera = codigo_carrera;
END;
//
DELIMITER ;

-- Consultar Estudiante
DELIMITER //
CREATE PROCEDURE consultaEstudiante(IN codigo_estudiante INT)
BEGIN
	IF NOT EsEnteroPositivo(codigo_estudiante) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se ha ingresado el codigo de la persona correctamente';
    END IF;
    SELECT carnet AS Carnet, concat(nombres," ", apellidos) AS Nombre, fecha_nacimiento AS FechaNacimiento, correo AS Correo, telefono AS Telefono, direccion AS Direccion, dpi AS DPI, id_carrera AS IdCarrera, creditos AS Creditos
    FROM estudiante
    WHERE carnet = codigo_estudiante;
END;
//
DELIMITER ;

-- COnsultar Docente
DELIMITER //
CREATE PROCEDURE consultaDocente(IN codigo_docente INT)
BEGIN
	IF NOT EsEnteroPositivo(codigo_docente) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se ha ingresado el codigo de la persona correctamente';
    END IF;
    SELECT id_docente AS SIIF, concat(nombres," ", apellidos) AS Nombre, fecha_nacimiento AS FechaNacimiento, correo AS Correo, telefono AS Telefono, direccion AS Direccion, dpi AS DPI
    FROM docente
    WHERE id_docente = codigo_docente;
END;
//
DELIMITER ;

-- Consultar estudiantes asignados
DELIMITER //
CREATE PROCEDURE consultarAsignados(
    IN codigo_curso INT,
    IN ciclo_nombre VARCHAR(2),
    IN ciclo_anio INT,
    IN seccion_letra CHAR(1)
)
BEGIN
	IF NOT ValidarValoresPermitidos(ciclo_nombre) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nombre de ciclo no válido';
    END IF;
    SET seccion_letra = UPPER(seccion_letra);
	IF NOT EsLetraAZ(seccion_letra) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Se ha ingresado un caracter diferente a una letra';
    END IF;
    IF NOT EsEnteroPositivo(ciclo_anio) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se ha ingresado el año correctamente';
    END IF;
    IF NOT EsEnteroPositivo(codigo_curso) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se ha ingresado el codigo del curso correctamente';
    END IF;
    SELECT 
        e.carnet AS Carnet,
        CONCAT(e.nombres, ' ', e.apellidos) AS Nombre,
        e.creditos AS Creditos
    FROM Estudiante e
    INNER JOIN Asignacion a ON e.carnet = a.carnet
    INNER JOIN CursoHabilitado ch ON a.id_cursohabilitado = ch.id_cursohabilitado
    INNER JOIN Seccion s ON ch.id_seccion = s.id_seccion
    INNER JOIN Ciclo ci ON ch.id_ciclo = ci.id_ciclo
    INNER JOIN Curso c ON ch.id_curso = c.id_curso
    WHERE c.id_curso = codigo_curso
    AND ci.nombre = ciclo_nombre
    AND YEAR(ch.fecha) = ciclo_anio
    AND s.letra = seccion_letra
    AND a.asignado = 1;
END;
//
DELIMITER ;

-- Consultar aprobados
DELIMITER //
CREATE PROCEDURE consultarAprobacion(
    IN codigo_curso INT,
    IN ciclo_nombre VARCHAR(2),
    IN ciclo_anio INT,
    IN seccion_letra CHAR(1)
)
BEGIN
    IF NOT ValidarValoresPermitidos(ciclo_nombre) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nombre de ciclo no válido';
    END IF;
    SET seccion_letra = UPPER(seccion_letra);
    IF NOT EsLetraAZ(seccion_letra) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Se ha ingresado un caracter diferente a una letra';
    END IF;
    IF NOT EsEnteroPositivo(ciclo_anio) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se ha ingresado el año correctamente';
    END IF;
    IF NOT EsEnteroPositivo(codigo_curso) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se ha ingresado el código del curso correctamente';
    END IF;

    SELECT 
        c.id_curso AS CodigoCurso,
        e.id_estudiante AS Carnet,
        CONCAT(e.nombre, ' ', e.apellido) AS NombreCompleto,
        CASE
            WHEN COUNT(n.id_nota) > 0 AND MIN(n.nota) >= 61 THEN 'APROBADO'
            ELSE 'REPROBADO'
        END AS Estado
    FROM Curso c
    JOIN CursoHabilitado ch ON c.id_curso = ch.id_curso
    JOIN Seccion s ON ch.id_seccion = s.id_seccion
    JOIN Ciclo ci ON ch.id_ciclo = ci.id_ciclo
    JOIN Asignacion a ON a.id_cursohabilitado = ch.id_cursohabilitado
    LEFT JOIN Nota n ON a.id_asignacion = n.id_asignacion
    JOIN Estudiante e ON a.id_estudiante = e.id_estudiante
    WHERE c.id_curso = codigo_curso
    AND ci.nombre = ciclo_nombre
    AND YEAR(ch.fecha) = ciclo_anio
    AND s.letra = seccion_letra
    AND a.asignado = 1 -- Añadir filtro para estudiantes asignados
    GROUP BY c.id_curso, e.id_estudiante, NombreCompleto;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE consultarActas(IN codigo_curso INT)
BEGIN
	IF NOT EsEnteroPositivo(codigo_curso) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se ha ingresado el código del curso correctamente';
    END IF;
    SELECT 
        c.id_curso AS CodigoCurso,
        s.letra AS Seccion,
        CASE
            WHEN ci.nombre = '1S' THEN 'PRIMER SEMESTRE'
            WHEN ci.nombre = '2S' THEN 'SEGUNDO SEMESTRE'
            WHEN ci.nombre = 'VJ' THEN 'VACACIONES DE JUNIO'
            WHEN ci.nombre = 'VD' THEN 'VACACIONES DE DICIEMBRE'
            ELSE ci.nombre
        END AS Ciclo,
        YEAR(ch.fecha) AS Anio,
        COUNT(n.id_nota) AS CantidadEstudiantes,
        act.fecha AS FechaGenerado
    FROM Curso c
    INNER JOIN CursoHabilitado ch ON c.id_curso = ch.id_curso
    INNER JOIN Seccion s ON ch.id_seccion = s.id_seccion
    INNER JOIN Ciclo ci ON ch.id_ciclo = ci.id_ciclo
    LEFT JOIN Asignacion a ON ch.id_cursohabilitado = a.id_cursohabilitado
    LEFT JOIN Nota n ON a.id_asignacion = n.id_asignacion
    LEFT JOIN Acta act ON a.id_cursohabilitado = act.id_cursohabilitado
    WHERE c.id_curso = codigo_curso AND act.fecha IS NOT NULL
    GROUP BY CodigoCurso, Seccion, Ciclo, Anio, FechaGenerado
    ORDER BY FechaGenerado;
END;
//
DELIMITER ;

-- Consultar Desasignados
DELIMITER //
CREATE PROCEDURE consultarDesasignacion(
    IN codigo_curso INT,
    IN ciclo_nombre VARCHAR(2),
    IN ciclo_anio INT,
    IN seccion_letra CHAR(1)
)
BEGIN
    DECLARE total_estudiantes INT;
    DECLARE desasignados INT;
    DECLARE porcentaje_desasignacion DECIMAL(5, 2);
    IF NOT ValidarValoresPermitidos(ciclo_nombre) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nombre de ciclo no válido';
    END IF;
    SET seccion_letra = UPPER(seccion_letra);
    IF NOT EsLetraAZ(seccion_letra) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Se ha ingresado un caracter diferente a una letra';
    END IF;
    IF NOT EsEnteroPositivo(ciclo_anio) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se ha ingresado el año correctamente';
    END IF;
    IF NOT EsEnteroPositivo(codigo_curso) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se ha ingresado el código del curso correctamente';
    END IF;
    SELECT COUNT(DISTINCT a.carnet)
    INTO total_estudiantes
    FROM Curso c
    INNER JOIN CursoHabilitado ch ON c.id_curso = ch.id_curso
    INNER JOIN Seccion s ON ch.id_seccion = s.id_seccion
    INNER JOIN Ciclo ci ON ch.id_ciclo = ci.id_ciclo
    INNER JOIN Asignacion a ON ch.id_cursohabilitado = a.id_cursohabilitado
    WHERE c.id_curso = codigo_curso
    AND ci.nombre = ciclo_nombre
    AND YEAR(ch.fecha) = ciclo_anio
    AND s.letra = seccion_letra;
    SELECT COUNT(DISTINCT a.carnet)
    INTO desasignados
    FROM Curso c
    INNER JOIN CursoHabilitado ch ON c.id_curso = ch.id_curso
    INNER JOIN Seccion s ON ch.id_seccion = s.id_seccion
    INNER JOIN Ciclo ci ON ch.id_ciclo = ci.id_ciclo
    INNER JOIN Asignacion a ON ch.id_cursohabilitado = a.id_cursohabilitado
    WHERE c.id_curso = codigo_curso
    AND ci.nombre = ciclo_nombre
    AND YEAR(ch.fecha) = ciclo_anio
    AND s.letra = seccion_letra
    AND a.asignado = 0;
    IF total_estudiantes > 0 THEN
        SET porcentaje_desasignacion = (desasignados / total_estudiantes) * 100;
    ELSE
        SET porcentaje_desasignacion = 0;
    END IF;
    SELECT 
        codigo_curso AS CodigoCurso,
        seccion_letra AS Seccion,
        CASE
            WHEN ciclo_nombre = '1S' THEN 'PRIMER SEMESTRE'
            WHEN ciclo_nombre = '2S' THEN 'SEGUNDO SEMESTRE'
            WHEN ciclo_nombre = 'VJ' THEN 'VACACIONES DE JUNIO'
            WHEN ciclo_nombre = 'VD' THEN 'VACACIONES DE DICIEMBRE'
            ELSE ciclo_nombre
        END AS Ciclo,
        ciclo_anio AS Anio,
        total_estudiantes AS TotalEstudiantes,
        desasignados AS Desasignados,
        porcentaje_desasignacion AS PorcentajeDesasignacion;
END;
//
DELIMITER ;



-- Borrar los datos de las tablas de la base de datos
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE CursoHabilitado;
TRUNCATE HorarioEnCurso;
TRUNCATE Horario;
TRUNCATE Acta;
TRUNCATE Nota;
TRUNCATE Asignacion;
TRUNCATE Estudiante;
TRUNCATE Docente;
TRUNCATE Curso;
TRUNCATE Seccion;
TRUNCATE Carrera;
TRUNCATE Ciclo;
TRUNCATE Bitacora;
SET FOREIGN_KEY_CHECKS = 1;


-- REGISTRO DE CARRERAS
CALL crearCarrera('Ingenieria Civil');       -- 1  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Ingenieria Industrial');  -- 2  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Ingenieria Sistemas');    -- 3  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Ingenieria Electronica'); -- 4  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Ingenieria Mecanica');    -- 5  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Ingenieria Mecatronica'); -- 6  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Ingenieria Quimica');     -- 7  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Ingenieria Ambiental');   -- 8  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Ingenieria Materiales');  -- 9  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Ingenieria Textil');      -- 10 VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE

-- REGISTRO DE DOCENTES
CALL registrarDocente('Docente1','Apellido1','30-10-1999','aadf@ingenieria.usac.edu.gt',12345678,'direccion',12345678910,1);
CALL registrarDocente('Docente2','Apellido2','20-11-1999','docente2@ingenieria.usac.edu.gt',12345678,'direcciondocente2',12345678911,2);
CALL registrarDocente('Docente3','Apellido3','20-12-1980','docente3@ingenieria.usac.edu.gt',12345678,'direcciondocente3',12345678912,3);
CALL registrarDocente('Docente4','Apellido4','20-11-1981','docente4@ingenieria.usac.edu.gt',12345678,'direcciondocente4',12345678913,4);
CALL registrarDocente('Docente5','Apellido5','20-09-1982','docente5@ingenieria.usac.edu.gt',12345678,'direcciondocente5',12345678914,5);

-- REGISTRO DE ESTUDIANTES
-- SISTEMAS
CALL registrarEstudiante(202000001,'Estudiante de','Sistemas Uno','30-10-1999','sistemasuno@gmail.com',12345678,'direccion estudiantes sistemas 1',337859510101,3);
CALL registrarEstudiante(202000002,'Estudiante de','Sistemas Dos','3-5-2000','sistemasdos@gmail.com',12345678,'direccion estudiantes sistemas 2',32781580101,3);
CALL registrarEstudiante(202000003,'Estudiante de','Sistemas Tres','3-5-2002','sistemastres@gmail.com',12345678,'direccion estudiantes sistemas 3',32791580101,3);
-- CIVIL
CALL registrarEstudiante(202100001,'Estudiante de','Civil Uno','3-5-1990','civiluno@gmail.com',12345678,'direccion de estudiante civil 1',3182781580101,1);
CALL registrarEstudiante(202100002,'Estudiante de','Civil Dos','03-08-1998','civildos@gmail.com',12345678,'direccion de estudiante civil 2',3181781580101,1);
-- INDUSTRIAL
CALL registrarEstudiante(202200001,'Estudiante de','Industrial Uno','30-10-1999','industrialuno@gmail.com',12345678,'direccion de estudiante industrial 1',3878168901,2);
CALL registrarEstudiante(202200002,'Estudiante de','Industrial Dos','20-10-1994','industrialdos@gmail.com',89765432,'direccion de estudiante industrial 2',29781580101,2);
-- ELECTRONICA
CALL registrarEstudiante(202300001, 'Estudiante de','Electronica Uno','20-10-2005','electronicauno@gmail.com',89765432,'direccion de estudiante electronica 1',29761580101,4);
CALL registrarEstudiante(202300002, 'Estudiante de','Electronica Dos', '01-01-2008','electronicados@gmail.com',12345678,'direccion de estudiante electronica 2',387916890101,4);
-- ESTUDIANTES RANDOM
CALL registrarEstudiante(201710160, 'ESTUDIANTE','SISTEMAS RANDOM','20-08-1994','estudiasist@gmail.com',89765432,'direccionestudisist random',29791580101,3);
CALL registrarEstudiante(201710161, 'ESTUDIANTE','CIVIL RANDOM','20-08-1995','estudiacivl@gmail.com',89765432,'direccionestudicivl random',30791580101,1);

-- AREA COMUN
CALL crearCurso(0006,'Idioma Tecnico 1',0,7,0,false); 
CALL crearCurso(0007,'Idioma Tecnico 2',0,7,0,false);
CALL crearCurso(101,'MB 1',0,7,0,true); 
CALL crearCurso(103,'MB 2',0,7,0,true); 
CALL crearCurso(017,'SOCIAL HUMANISTICA 1',0,4,0,true); 
CALL crearCurso(019,'SOCIAL HUMANISTICA 2',0,4,0,true); 
CALL crearCurso(348,'QUIMICA GENERAL',0,3,0,true); 
CALL crearCurso(349,'QUIMICA GENERAL LABORATORIO',0,1,0,true);
-- INGENIERIA EN SISTEMAS
CALL crearCurso(777,'Compiladores 1',80,4,3,true); 
CALL crearCurso(770,'INTR. A la Programacion y computacion 1',0,4,3,true); 
CALL crearCurso(960,'MATE COMPUTO 1',33,5,3,true); 
CALL crearCurso(795,'lOGICA DE SISTEMAS',33,2,3,true);
CALL crearCurso(796,'LENGUAJES FORMALES Y DE PROGRAMACIÓN',0,3,3,TRUE);
-- INGENIERIA INDUSTRIAL
CALL crearCurso(123,'Curso Industrial 1',0,4,2,true); 
CALL crearCurso(124,'Curso Industrial 2',0,4,2,true);
CALL crearCurso(125,'Curso Industrial enseñar a pensar',10,2,2,false);
CALL crearCurso(126,'Curso Industrial ENSEÑAR A DIBUJAR',2,4,2,true);
CALL crearCurso(127,'Curso Industrial 3',8,4,2,true);
-- INGENIERIA CIVIL
CALL crearCurso(321,'Curso Civil 1',0,4,1,true);
CALL crearCurso(322,'Curso Civil 2',4,4,1,true);
CALL crearCurso(323,'Curso Civil 3',8,4,1,true);
CALL crearCurso(324,'Curso Civil 4',12,4,1,true);
CALL crearCurso(325,'Curso Civil 5',16,4,1,false);
CALL crearCurso(0250,'Mecanica de Fluidos',0,5,1,true);
-- INGENIERIA ELECTRONICA
CALL crearCurso(421,'Curso Electronica 1',0,4,4,true);
CALL crearCurso(422,'Curso Electronica 2',4,4,4,true);
CALL crearCurso(423,'Curso Electronica 3',8,4,4,false);
CALL crearCurso(424,'Curso Electronica 4',12,4,4,true);
CALL crearCurso(425,'Curso Electronica 5',16,4,4,true);