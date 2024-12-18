package cmd

import "github.com/spf13/cobra"

// Root Command
var rootCmd = &cobra.Command{
	Use:   "torcontroller",
	Short: "Tor Controller CLI",
	Long:  "A CLI to control Tor and Privoxy services.",
}

var socketPath = "/tmp/torcontroller.sock"

var pidFile = "/tmp/torcontroller.pid"

// Initialize Root Command
func InitCommands() *cobra.Command {
	rootCmd.AddCommand(
		versionCmd,
		startCmd,
		startBackgroundCmd,
		stopCmd,
	)
	return rootCmd
}