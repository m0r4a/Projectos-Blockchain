package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"
	"strconv"

	"github.com/gagliardetto/solana-go/rpc"
)

func main() {
	if len(os.Args) != 2 {
		fmt.Fprintf(os.Stderr, "usage: %s <block_number>\n", os.Args[0])
		os.Exit(1)
	}

	blockNum, err := strconv.ParseUint(os.Args[1], 10, 64)
	if err != nil {
		fmt.Fprintf(os.Stderr, "error: invalid block number: %v\n", err)
		os.Exit(1)
	}

	client := rpc.New(rpc.MainNetBeta_RPC)
	
	block, err := client.GetBlock(context.Background(), blockNum)
	if err != nil {
		fmt.Fprintf(os.Stderr, "error: failed to get block: %v\n", err)
		os.Exit(1)
	}

	filename := fmt.Sprintf("block_%d.json", blockNum)
	data, err := json.MarshalIndent(block, "", "  ")
	if err != nil {
		fmt.Fprintf(os.Stderr, "error: failed to marshal block: %v\n", err)
		os.Exit(1)
	}

	if err := os.WriteFile(filename, data, 0644); err != nil {
		fmt.Fprintf(os.Stderr, "error: failed to write file: %v\n", err)
		os.Exit(1)
	}

	fmt.Printf("block saved to %s\n", filename)
}
