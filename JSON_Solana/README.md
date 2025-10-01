# json_solana

Descarga bloques de la mainnet de Solana y los guarda en formato JSON.

## Requisitos

- Go 1.21+

## Instalación

1. Clonar el repositorio

```bash
git clone https://github.com/m0r4a/Projectos-Blockchain.git
```

2. Entrar al projecto

```bash
cd Projectos-Blockchain/JSON_Solana
```

3. Instalar dependencias y compilar

```bash
make setup
```

## Uso

```bash
./json_solana <block_number>
```

**Ejemplo:**

```bash
./json_solana 1234
```

Genera un archivo `block_1234.json` con los datos del bloque.

## Comandos

```bash
make        # Compilar
make setup  # Descargar dependencias y compilar
make test   # Ejecutar con bloque de prueba
make clean  # Limpiar binarios y archivos generados
```

## Dependencias

- [gagliardetto/solana-go](https://github.com/gagliardetto/solana-go) - Cliente RPC de Solana
