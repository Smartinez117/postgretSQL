#!/usr/bin/python
import psycopg2
#version que si funciona con create y el menu.
# Función para conectarse a la base de datos
def connect_db():
    credenciales = {
        "dbname": "presentacion1",
        "user": "postgres",
        "password": "basededatos",#no mires XD
        "host": "localhost",
        "port": 5432
    }
    return psycopg2.connect(**credenciales)

# Función para crear la tabla si no existe
def create_table():
    try:
        conn = connect_db()
        cur = conn.cursor()
        cur.execute("""
            CREATE TABLE IF NOT EXISTS tablaPrueba1 (
                id SERIAL PRIMARY KEY,
                nombre VARCHAR(100) NOT NULL,
                edad INT NOT NULL,
                carrera VARCHAR(20) NOT NULL
            )
        """)
        conn.commit()
        print("Tabla 'tablaPrueba1' verificada o creada exitosamente.")
    except Exception as e:
        print(f"Error al crear la tabla: {str(e)}")
    finally:
        cur.close()
        conn.close()

# Función para insertar un nuevo registro
def create_record(nombre, edad, carrera):
    try:
        conn = connect_db()
        cur = conn.cursor()
        cur.execute("INSERT INTO tablaPrueba1 (nombre, edad, carrera) VALUES (%s, %s, %s)", (nombre, edad, carrera))
        conn.commit()
        print(f"Registro '{nombre}' creado exitosamente.")
    except Exception as e:
        print(f"Error al crear el registro: {str(e)}")
    finally:
        cur.close()
        conn.close()

# Función para leer todos los registros
def read_records():
    try:
        conn = connect_db()
        cur = conn.cursor()
        cur.execute("SELECT * FROM tablaPrueba1")
        resultados = cur.fetchall()
        
        if resultados:
            for fila in resultados:
                print(f"ID: {fila[0]}, Nombre: {fila[1]}, Edad: {fila[2]}, Carrera: {fila[3]}")
        else:
            print("No hay registros en la tabla.")
    except Exception as e:
        print(f"Error al leer los registros: {str(e)}")
    finally:
        cur.close()
        conn.close()

# Función para actualizar un registro existente
def update_record(record_id, new_name, new_age, new_career):
    try:
        conn = connect_db()
        cur = conn.cursor()
        cur.execute("UPDATE tablaPrueba1 SET nombre = %s, edad = %s, carrera = %s WHERE id = %s", (new_name, new_age, new_career, record_id))
        conn.commit()
        
        if cur.rowcount > 0:
            print(f"Registro con ID {record_id} actualizado a '{new_name}', Edad: {new_age}, Carrera: '{new_career}'.")
        else:
            print(f"No se encontró el registro con ID {record_id}.")
    except Exception as e:
        print(f"Error al actualizar el registro: {str(e)}")
    finally:
        cur.close()
        conn.close()

# Función para eliminar un registro por ID
def delete_record(record_id):
    try:
        conn = connect_db()
        cur = conn.cursor()
        cur.execute("DELETE FROM tablaPrueba1 WHERE id = %s", (record_id,))
        conn.commit()
        
        if cur.rowcount > 0:
            print(f"Registro con ID {record_id} eliminado exitosamente.")
        else:
            print(f"No se encontró el registro con ID {record_id}.")
    except Exception as e:
        print(f"Error al eliminar el registro: {str(e)}")
    finally:
        cur.close()
        conn.close()

# Función principal que muestra el menú y maneja las opciones del usuario
def main_menu():
    create_table()  # Verificar o crear la tabla al inicio

    while True:
        print("\n--- Menú de Opciones ---")
        print("1. Insertar nuevo registro")
        print("2. Leer registros")
        print("3. Actualizar registro")
        print("4. Eliminar registro")
        print("5. Salir")

        opcion = input("Seleccione una opción (1-5): ")

        if opcion == '1':
            nombre = input("Ingrese el nombre del nuevo registro: ")
            edad = int(input("Ingrese la edad del nuevo registro: "))
            carrera = input("Ingrese la carrera del nuevo registro (máximo 20 caracteres): ")
            create_record(nombre, edad, carrera)
        
        elif opcion == '2':
            read_records()

        elif opcion == '3':
            record_id = int(input("Ingrese el ID del registro a actualizar: "))
            new_name = input("Ingrese el nuevo nombre: ")
            new_age = int(input("Ingrese la nueva edad: "))
            new_career = input("Ingrese la nueva carrera (máximo 20 caracteres): ")
            update_record(record_id, new_name, new_age, new_career)

        elif opcion == '4':
            record_id = int(input("Ingrese el ID del registro a eliminar: "))
            delete_record(record_id)

        elif opcion == '5':
            print("Saliendo del programa...")
            break
        
        else:
            print("Opción no válida. Por favor intente de nuevo.")

if __name__ == '__main__':
    main_menu()  # Iniciar el menú principal