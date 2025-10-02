# Greeting Contract - Pact

Smart contract en Pact que almacena nombres en una tabla y los saluda usando keysets.

## Requisitos

- Pact 4.x

## Instalación de Pact

```bash
# Arch Linux - desde AUR
yay -S pact

# O descarga binarios
curl -L https://github.com/kadena-io/pact/releases/download/v4.12/pact-4.12-linux-22.04.tar.gz | tar xz
sudo mv pact /usr/local/bin/
```

Verifica:
```bash
pact --version
```

## Ejecutar Tests

```bash
pact greeting.repl
```

## Características del Contrato

**Keysets:**
- `admin-keyset`: Keyset del administrador
- `user-keyset`: Keyset de cada usuario

**Capability:**
- `GOVERNANCE`: Control del módulo

**Funciones:**
- `store-name`: Almacena nombre en la tabla
- `greet`: Saluda usando el nombre almacenado

**Schema:**
- `name-schema`: Define la estructura (name, guard)

**Tabla:**
- `names-table`: Almacena los nombres

## Tests

Los tests cubren:
- Almacenar nombres
- Saludar usuarios
- Validación de nombres vacíos
- Múltiples usuarios

## Troubleshooting

**Error: "Keyset failure"**
- Verifica que el keyset esté definido
- Activa las keys correctas

**Error: "row not found"**
- El usuario no tiene nombre almacenado
- Llama `store-name` primero

**Error: "Name cannot be empty"**
- No se permiten nombres vacíos

## Recursos

- [Pact Language Reference](https://pact-language.readthedocs.io/)
- [Kadena Documentation](https://docs.kadena.io/)
- [Pact GitHub](https://github.com/kadena-io/pact)
