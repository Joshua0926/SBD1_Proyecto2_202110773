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
        e.carnet AS Carnet,
        CONCAT(e.nombres, ' ', e.apellidos) AS NombreCompleto,
        CASE
            WHEN COUNT(n.id_nota) > 0 AND MIN(n.nota) >= 61 THEN 'APROBADO'
            ELSE 'REPROBADO'
        END AS Estado
    FROM Curso c
    CROSS JOIN Estudiante e
    LEFT JOIN Asignacion a ON e.carnet = a.carnet
    LEFT JOIN Nota n ON a.id_asignacion = n.id_asignacion
    INNER JOIN CursoHabilitado ch ON c.id_curso = ch.id_curso
    INNER JOIN Seccion s ON ch.id_seccion = s.id_seccion
    INNER JOIN Ciclo ci ON ch.id_ciclo = ci.id_ciclo
    WHERE c.id_curso = codigo_curso
    AND ci.nombre = ciclo_nombre
    AND YEAR(ch.fecha) = ciclo_anio
    AND s.letra = seccion_letra
    GROUP BY c.id_curso, e.carnet, NombreCompleto;
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

-- Carga de datos a las Tablas
CALL crearCarrera('Civil');
CALL crearCarrera('Industrial');
CALL crearCarrera('Sistemas');
CALL crearCarrera('Mecanica');

CALL registrarDocente(200200001,'Javier','Guzmán','1990-01-31','edu@gmail.com',78693541,'123 Main St, Ciudad 0101',2997859610101);
CALL registrarDocente(200200002,'María','López','1985-07-15','maria@gmail.com',71234567,'456 Elm St, Villa 0101',2997859610102);
CALL registrarDocente(200200003,'Carlos','Pérez','1980-03-22','carlos@gmail.com',65432109,'789 Oak St, Pueblo 0101',2997859610103);
CALL registrarDocente(200200004,'Luisa','Ramírez','1988-11-10','luisa@gmail.com',89012345,'101 Pine St, Colonia 0101',2997859610104);
CALL registrarDocente(200200005,'Ana','Martínez','1995-05-05','ana@gmail.com',62345678,'222 Cedar St, Aldea 0101',2997859610105);

CALL registrarEstudiante(202300001,'Diego','Torres','2003-04-28','diego@example.com',65432109,'678 Avenida Secundaria',1234567890101,1);
CALL registrarEstudiante(202300002,'Elena','Vargas','2001-10-03','elena@gmail.com',89674321,'234 Ruta Secundaria',9876543210102,2);
CALL registrarEstudiante(202300003,'Pedro','López','2001-05-12','pedro@example.com',12345678,'789 Avenida Principal',1234567890123,1);
CALL registrarEstudiante(202300004,'Laura','Ramírez','1999-12-08','laura@gmail.com',98765432,'101 Calle Principal',9876543210987,2);
CALL registrarEstudiante(202300005,'Carlos','Martínez','2003-03-25','carlos@example.com',56473829,'234 Carretera Principal',9876543210101,3);
CALL registrarEstudiante(202300006,'Ana','González','2000-09-17','ana@gmail.com',45678901,'567 Camino Principal',2997536980101,4);
CALL registrarEstudiante(202300007,'Luis','Hernández','2004-07-31','luis@example.com',78901234,'123 Calle Secundaria',1234567890987,3);
CALL registrarEstudiante(202300008,'María','Pérez','1997-02-14','maria@gmail.com',23568974,'890 Ruta Principal',2997536980102,2);
CALL registrarEstudiante(202300009,'Juan','Rodríguez','2002-11-19','juan@example.com',78965432,'567 Ruta Secundaria',9876543210103,4);
CALL registrarEstudiante(202300010,'Sofía','Díaz','1998-06-05','sofia@gmail.com',45678912,'456 Camino Secundario',2997536980104,3);

CALL crearCurso(101, 'Mate Basica 1', 0, 6, 0, 1);
CALL crearCurso(102, 'Etica', 0, 3, 0, 1);
CALL crearCurso(103, 'Idioma Técnico', 0, 4, 0, 1);
CALL crearCurso(104, 'Física General', 0, 5, 0, 1);
CALL crearCurso(105, 'Química Aplicada', 0, 4, 0, 1);
CALL crearCurso(201, 'Mecánica de Materiales', 0, 6, 1, 1);
CALL crearCurso(202, 'Diseño Estructural', 0, 9, 1, 1);
CALL crearCurso(203, 'Hidráulica', 10, 7, 1, 1);
CALL crearCurso(204, 'Geotecnia', 8, 6, 1, 1);
CALL crearCurso(205, 'Topografía', 6, 5, 1, 1);
CALL crearCurso(301, 'Procesos de Manufactura', 0, 8, 2, 1);
CALL crearCurso(302, 'Gestión de la Calidad', 0, 7, 2, 1);
CALL crearCurso(303, 'Automatización Industrial', 10, 9, 2, 1);
CALL crearCurso(304, 'Logística y Cadena de Suministro', 8, 7, 2, 1);
CALL crearCurso(305, 'Diseño de Productos', 12, 10, 2, 1);
CALL crearCurso(401, 'Programación Avanzada', 0, 7, 3, 1);
CALL crearCurso(402, 'Bases de Datos', 0, 7, 3, 1);
CALL crearCurso(403, 'Redes de Computadoras', 10, 8, 3, 1);
CALL crearCurso(404, 'Inteligencia Artificial', 10, 9, 3, 1);
CALL crearCurso(405, 'Seguridad Informática', 8, 7, 3, 1);
CALL crearCurso(501, 'Termodinámica', 0, 7, 4, 1);
CALL crearCurso(502, 'Dinámica de Máquinas', 0, 9, 4, 1);
CALL crearCurso(503, 'Diseño de Elementos Mecánicos', 10, 8, 4, 1);
CALL crearCurso(504, 'Mecánica de Fluidos', 8, 7, 4, 1);
CALL crearCurso(505, 'Proyectos de Ingeniería Mecánica', 12, 10, 4, 1);

-- ---------------------------------------------------------------------------

-- Habilitación de Cursos de Área Común
CALL habilitarCurso(101, '1S', 200200001, 75, 'A');
CALL habilitarCurso(102, '1S', 200200002, 50, 'B');
CALL habilitarCurso(101, '2S', 200200002, 50, 'C');
CALL habilitarCurso(103, '1S', 200200003, 40, 'D');
CALL habilitarCurso(104, '2S', 200200004, 90, 'E');

-- Habilitación de Cursos de Carrera Civil
CALL habilitarCurso(201, '1S', 200200001, 70, 'A');
CALL habilitarCurso(201, 'VJ', 200200001, 70, 'B');
CALL habilitarCurso(202, '1S', 200200002, 35, 'C');
CALL habilitarCurso(202, '2S', 200200002, 35, 'D');
CALL habilitarCurso(203, '1S', 200200003, 80, 'E');
CALL habilitarCurso(203, '2S', 200200003, 80, 'F');
CALL habilitarCurso(204, '1S', 200200004, 45, 'A');
CALL habilitarCurso(204, 'VD', 200200004, 45, 'B');
CALL habilitarCurso(205, '1S', 200200005, 55, 'C');
CALL habilitarCurso(205, 'VD', 200200005, 55, 'D');

-- Habilitación de Cursos de Carrera Industrial
CALL habilitarCurso(301, '1S', 200200001, 95, 'E');
CALL habilitarCurso(301, '2S', 200200001, 95, 'F');
CALL habilitarCurso(302, '1S', 200200002, 30, 'A');
CALL habilitarCurso(302, 'VJ', 200200002, 30, 'B');
CALL habilitarCurso(303, 'VJ', 200200003, 110, 'C');
CALL habilitarCurso(303, '2S', 200200003, 110, 'D');
CALL habilitarCurso(304, '1S', 200200004, 75, 'E');
CALL habilitarCurso(304, '2S', 200200004, 75, 'F');
CALL habilitarCurso(305, '1S', 200200005, 65, 'A');
CALL habilitarCurso(305, 'VD', 200200005, 65, 'B');

-- Habilitación de Cursos de Carrera de Sistemas
CALL habilitarCurso(401, '1S', 200200001, 85, 'C');
CALL habilitarCurso(401, '2S', 200200001, 85, 'D');
CALL habilitarCurso(402, '1S', 200200002, 100, 'E');
CALL habilitarCurso(402, 'VJ', 200200002, 100, 'F');
CALL habilitarCurso(403, '1S', 200200003, 70, 'G');
CALL habilitarCurso(403, '2S', 200200003, 70, 'H');
CALL habilitarCurso(404, '1S', 200200004, 45, 'I');
CALL habilitarCurso(404, '2S', 200200004, 45, 'J');
CALL habilitarCurso(405, '1S', 200200005, 60, 'K');
CALL habilitarCurso(405, 'VD', 200200005, 60, 'L');

-- Habilitación de Cursos de Carrera Mecánica
CALL habilitarCurso(501, '1S', 200200001, 85, 'L');
CALL habilitarCurso(501, '2S', 200200001, 85, 'M');
CALL habilitarCurso(502, '1S', 200200002, 100, 'N');
CALL habilitarCurso(502, '2S', 200200002, 100, 'O');
CALL habilitarCurso(503, '1S', 200200003, 70, 'P');
CALL habilitarCurso(503, 'VJ', 200200003, 70, 'A');
CALL habilitarCurso(504, '1S', 200200004, 45, 'B');
CALL habilitarCurso(504, '2S', 200200004, 45, 'C');
CALL habilitarCurso(505, '2S', 200200005, 60, 'M');
CALL habilitarCurso(505, 'VD', 200200005, 60, 'N');

CALL agregarHorario(1, 2, '6:50-7:40');
CALL agregarHorario(2, 5, '7:50-8:40');
CALL agregarHorario(3, 3, '8:50-9:40');
CALL agregarHorario(4, 7, '9:50-10:40');
CALL agregarHorario(5, 1, '10:50-11:40');
CALL agregarHorario(6, 4, '11:50-12:40');
CALL agregarHorario(7, 6, '12:50-13:40');
CALL agregarHorario(8, 2, '13:50-14:40');
CALL agregarHorario(9, 5, '14:50-15:40');
CALL agregarHorario(10, 3, '15:50-16:40');
CALL agregarHorario(11, 1, '16:50-17:40');
CALL agregarHorario(12, 4, '17:50-18:40');
CALL agregarHorario(13, 2, '18:50-19:40');
CALL agregarHorario(14, 6, '19:50-20:40');
CALL agregarHorario(15, 1, '6:50-7:40');
CALL agregarHorario(16, 4, '7:50-8:40');
CALL agregarHorario(17, 6, '8:50-9:40');
CALL agregarHorario(18, 2, '9:50-10:40');
CALL agregarHorario(19, 5, '10:50-11:40');
CALL agregarHorario(20, 3, '11:50-12:40');
CALL agregarHorario(21, 2, '12:50-13:40');
CALL agregarHorario(22, 5, '13:50-14:40');
CALL agregarHorario(23, 3, '14:50-15:40');
CALL agregarHorario(24, 7, '15:50-16:40');
CALL agregarHorario(25, 1, '16:50-17:40');
CALL agregarHorario(26, 4, '17:50-18:40');
CALL agregarHorario(27, 6, '18:50-19:40');
CALL agregarHorario(28, 2, '19:50-20:40');
CALL agregarHorario(29, 5, '6:50-7:40');
CALL agregarHorario(30, 3, '7:50-8:40');
CALL agregarHorario(31, 1, '8:50-9:40');
CALL agregarHorario(32, 4, '9:50-10:40');
CALL agregarHorario(33, 2, '10:50-11:40');
CALL agregarHorario(34, 6, '11:50-12:40');
CALL agregarHorario(35, 1, '12:50-13:40');
CALL agregarHorario(36, 4, '13:50-14:40');
CALL agregarHorario(37, 6, '14:50-15:40');
CALL agregarHorario(38, 2, '15:50-16:40');
CALL agregarHorario(39, 5, '16:50-17:40');
CALL agregarHorario(40, 3, '17:50-18:40');
CALL agregarHorario(41, 2, '18:50-19:40');
CALL agregarHorario(42, 5, '19:50-20:40');
CALL agregarHorario(43, 3, '17:50-18:40');
CALL agregarHorario(44, 2, '18:50-19:40');
CALL agregarHorario(45, 5, '19:50-20:40');
CALL agregarHorario(1, 4, '6:50-7:40');
CALL agregarHorario(2, 7, '7:50-8:40');
CALL agregarHorario(3, 4, '8:50-9:40');
CALL agregarHorario(4, 1, '9:50-10:40');
CALL agregarHorario(5, 6, '10:50-11:40');
CALL agregarHorario(6, 5, '11:50-12:40');
CALL agregarHorario(7, 3, '12:50-13:40');
CALL agregarHorario(8, 2, '13:50-14:40');
CALL agregarHorario(9, 1, '14:50-15:40');
CALL agregarHorario(10, 5, '15:50-16:40');

-- Estudiante 202300001 (Diego) - Carrera: Civil (código 1)
CALL asignarCurso(101, '1S', 'A', 202300001);
CALL asignarCurso(102, '1S', 'B', 202300001);
CALL asignarCurso(201, '1S', 'A', 202300001);
CALL asignarCurso(202, '1S', 'C', 202300001);

-- Estudiante 202300002 (Elena) - Carrera: Industrial (código 2)
CALL asignarCurso(101, '1S', 'A', 202300002);
CALL asignarCurso(102, '1S', 'B', 202300002);
CALL asignarCurso(301, '1S', 'E', 202300002);
CALL asignarCurso(302, '1S', 'A', 202300002);

-- Estudiante 202300003 (Pedro) - Carrera: Civil (código 1)
CALL asignarCurso(101, '1S', 'A', 202300003);
CALL asignarCurso(102, '1S', 'B', 202300003);
CALL asignarCurso(201, '1S', 'A', 202300003);
CALL asignarCurso(202, '1S', 'C', 202300003);

-- Estudiante 202300004 (Laura) - Carrera: Industrial (código 2)
CALL asignarCurso(101, '1S', 'A', 202300004);
CALL asignarCurso(102, '1S', 'B', 202300004);
CALL asignarCurso(301, '1S', 'E', 202300004);
CALL asignarCurso(302, '1S', 'A', 202300004);

-- Estudiante 202300005 (Carlos) - Carrera: Sistemas (código 3)
CALL asignarCurso(101, '1S', 'A', 202300005);
CALL asignarCurso(102, '1S', 'B', 202300005);
CALL asignarCurso(401, '1S', 'C', 202300005);
CALL asignarCurso(402, '1S', 'E', 202300005);

-- Estudiante 202300006 (Ana) - Carrera: Mecánica (código 4)
CALL asignarCurso(101, '1S', 'A', 202300006);
CALL asignarCurso(102, '1S', 'B', 202300006);
CALL asignarCurso(501, '1S', 'L', 202300006);
CALL asignarCurso(502, '1S', 'N', 202300006);

-- Estudiante 202300007 (Luis) - Carrera: Sistemas (código 3)
CALL asignarCurso(101, '1S', 'A', 202300007);
CALL asignarCurso(102, '1S', 'B', 202300007);
CALL asignarCurso(401, '1S', 'C', 202300007);
CALL asignarCurso(402, '1S', 'E', 202300007);

-- Estudiante 202300008 (María) - Carrera: Industrial (código 2)
CALL asignarCurso(101, '1S', 'A', 202300008);
CALL asignarCurso(102, '1S', 'B', 202300008);
CALL asignarCurso(301, '1S', 'E', 202300008);
CALL asignarCurso(302, '1S', 'A', 202300008);

-- Estudiante 202300009 (Juan) - Carrera: Mecánica (código 4)
CALL asignarCurso(101, '1S', 'A', 202300009);
CALL asignarCurso(102, '1S', 'B', 202300009);
CALL asignarCurso(501, '1S', 'L', 202300009);
CALL asignarCurso(502, '1S', 'N', 202300009);

-- Estudiante 202300010 (Sofía) - Carrera: Sistemas (código 3)
CALL asignarCurso(101, '1S', 'A', 202300010);
CALL asignarCurso(102, '1S', 'B', 202300010);
CALL asignarCurso(401, '1S', 'C', 202300010);
CALL asignarCurso(402, '1S', 'E', 202300010);

CALL desasignarCurso(101, '1S', 'A', 202300001); -- Estudiante 202300001
CALL desasignarCurso(101, '1S', 'A', 202300002); -- Estudiante 202300002
CALL desasignarCurso(101, '1S', 'A', 202300003); -- Estudiante 202300003
CALL desasignarCurso(101, '1S', 'A', 202300004); -- Estudiante 202300004
CALL desasignarCurso(101, '1S', 'A', 202300005); -- Estudiante 202300005

-- Estudiante 202300001 (Diego) - Carrera: Civil (código 1)
CALL ingresarNota(102, '1S', 'B', 202300001, 78);
CALL ingresarNota(201, '1S', 'A', 202300001, 92);
CALL ingresarNota(202, '1S', 'C', 202300001, 85);

-- Estudiante 202300002 (Elena) - Carrera: Industrial (código 2)
CALL ingresarNota(102, '1S', 'B', 202300002, 88);
CALL ingresarNota(301, '1S', 'E', 202300002, 76);
CALL ingresarNota(302, '1S', 'A', 202300002, 95);

-- Estudiante 202300003 (Pedro) - Carrera: Civil (código 1)
CALL ingresarNota(102, '1S', 'B', 202300003, 88);
CALL ingresarNota(201, '1S', 'A', 202300003, 75);
CALL ingresarNota(202, '1S', 'C', 202300003, 91);

-- Estudiante 202300004 (Laura) - Carrera: Industrial (código 2)
CALL ingresarNota(102, '1S', 'B', 202300004, 95);
CALL ingresarNota(301, '1S', 'E', 202300004, 77);
CALL ingresarNota(302, '1S', 'A', 202300004, 89);

-- Estudiante 202300005 (Carlos) - Carrera: Sistemas (código 3)
CALL ingresarNota(102, '1S', 'B', 202300005, 78);
CALL ingresarNota(401, '1S', 'C', 202300005, 88);
CALL ingresarNota(402, '1S', 'E', 202300005, 95);

-- Estudiante 202300006 (Ana) - Carrera: Mecánica (código 4)
CALL ingresarNota(101, '1S', 'A', 202300006, 61);
CALL ingresarNota(102, '1S', 'B', 202300006, 60);
CALL ingresarNota(501, '1S', 'L', 202300006, 92);
CALL ingresarNota(502, '1S', 'N', 202300006, 79);

-- Estudiante 202300007 (Luis) - Carrera: Sistemas (código 3)
CALL ingresarNota(101, '1S', 'A', 202300007, 85);
CALL ingresarNota(102, '1S', 'B', 202300007, 90);
CALL ingresarNota(401, '1S', 'C', 202300007, 35);
CALL ingresarNota(402, '1S', 'E', 202300007, 75);

-- Estudiante 202300008 (María) - Carrera: Industrial (código 2)
CALL ingresarNota(101, '1S', 'A', 202300008, 81);
CALL ingresarNota(102, '1S', 'B', 202300008, 78);
CALL ingresarNota(301, '1S', 'E', 202300008, 38);
CALL ingresarNota(302, '1S', 'A', 202300008, 90);

-- Estudiante 202300009 (Juan) - Carrera: Mecánica (código 4)
CALL ingresarNota(101, '1S', 'A', 202300009, 76);
CALL ingresarNota(102, '1S', 'B', 202300009, 85);
CALL ingresarNota(501, '1S', 'L', 202300009, 44);
CALL ingresarNota(502, '1S', 'N', 202300009, 73);

-- Estudiante 202300010 (Sofía) - Carrera: Sistemas (código 3)
CALL ingresarNota(101, '1S', 'A', 202300010, 80);
CALL ingresarNota(102, '1S', 'B', 202300010, 82);
CALL ingresarNota(401, '1S', 'C', 202300010, 60);
CALL ingresarNota(402, '1S', 'E', 202300010, 91);


CALL generarActa(101, '1S', 'A');
CALL generarActa(102, '1S', 'B');
CALL generarActa(201, '1S', 'A');
CALL generarActa(202, '1S', 'C');
CALL generarActa(301, '1S', 'E');
CALL generarActa(302, '1S', 'A');
CALL generarActa(401, '1S', 'C');
CALL generarActa(402, '1S', 'E');
CALL generarActa(501, '1S', 'L');
CALL generarActa(502, '1S', 'N');

CALL asignarCurso(101, '2S', 'C', 202300001); -- Estudiante 202300001
CALL asignarCurso(101, '2S', 'C', 202300002); -- Estudiante 202300002
CALL asignarCurso(101, '2S', 'C', 202300003); -- Estudiante 202300003
CALL asignarCurso(101, '2S', 'C', 202300004); -- Estudiante 202300004
CALL asignarCurso(101, '2S', 'C', 202300005); -- Estudiante 202300005
CALL ingresarNota(101, '2S', 'C', 202300001, 61); -- Estudiante 202300001
CALL ingresarNota(101, '2S', 'C', 202300002, 75); -- Estudiante 202300002
CALL ingresarNota(101, '2S', 'C', 202300003, 58); -- Estudiante 202300003
CALL ingresarNota(101, '2S', 'C', 202300004, 68); -- Estudiante 202300004
CALL ingresarNota(101, '2S', 'C', 202300005, 92); -- Estudiante 202300005
CALL generarActa(101, '2S', 'c');
CALL asignarCurso(503, '1S', 'P', 202300006);


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

