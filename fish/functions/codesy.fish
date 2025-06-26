#!/usr/bin/env fish

# codesy.fish - VS Code recent projects selector using fzf in floating kitty
# Usage: codesy [--logs]

function codesy
    # Check for debug flag
    set -l debug_mode false
    if test "$argv[1]" = "--logs"
        set debug_mode true
    end
    
    set -l vscode_db "$HOME/.config/Code/User/globalStorage/state.vscdb"
    
    # Check if VS Code database exists
    if not test -f "$vscode_db"
        echo "Error: VS Code database not found at $vscode_db"
        return 1
    end

    # Get recent projects from VS Code database
    set -l recent_data (sqlite3 "$vscode_db" "SELECT value FROM ItemTable where key ='history.recentlyOpenedPathsList'" 2>/dev/null)
    
    if test -z "$recent_data"
        echo "Error: Could not retrieve recent projects from VS Code"
        return 1
    end

    if test "$debug_mode" = "true"
        echo "Debug: Raw VS Code data retrieved successfully"
        echo "Debug: Data length: "(echo "$recent_data" | wc -c)
    end

    # Parse JSON and extract folder paths (both local and remote)
    set -l projects_list
    
    if test "$debug_mode" = "true"
        echo "Debug: Starting to parse JSON entries..."
    end
    
    for entry in (echo "$recent_data" | jq -c '.entries[]')
        set -l folder_uri (echo "$entry" | jq -r '.folderUri // empty')
        set -l file_uri (echo "$entry" | jq -r '.fileUri // empty')
        set -l remote_authority (echo "$entry" | jq -r '.remoteAuthority // "null"')
        set -l label (echo "$entry" | jq -r '.label // empty')
        
        if test "$debug_mode" = "true"
            echo "Debug: Processing entry:"
            echo "  folder_uri: $folder_uri"
            echo "  file_uri: $file_uri"
            echo "  remote_authority: $remote_authority"
            echo "  label: $label"
        end
        
        # Only process folder URIs, skip file URIs
        if test -n "$folder_uri"
            if test "$remote_authority" = "null"
                # Local folder - extract path from file:// URI
                set -l path (echo "$folder_uri" | sed 's|^file://||')
                if test -d "$path"
                    # Create display name for local folders
                    if test -n "$label" -a "$label" != "null"
                        set projects_list $projects_list "$label|local|$path"
                        if test "$debug_mode" = "true"
                            echo "  Added LOCAL with label: $label|local|$path"
                        end
                    else
                        set -l basename_path (basename "$path")
                        set projects_list $projects_list "$basename_path|local|$path"
                        if test "$debug_mode" = "true"
                            echo "  Added LOCAL with basename: $basename_path|local|$path"
                        end
                    end
                else
                    if test "$debug_mode" = "true"
                        echo "  Skipped LOCAL (directory doesn't exist): $path"
                    end
                end
            else
                # Remote folder - use full folder URI
                if test -n "$label" -a "$label" != "null"
                    set projects_list $projects_list "$label|remote|$folder_uri"
                    if test "$debug_mode" = "true"
                        echo "  Added REMOTE with label: $label|remote|$folder_uri"
                    end
                else
                    # Extract a reasonable name from the URI
                    set -l basename_path (basename (echo "$folder_uri" | sed 's|.*/||'))
                    set projects_list $projects_list "$basename_path|remote|$folder_uri"
                    if test "$debug_mode" = "true"
                        echo "  Added REMOTE with basename: $basename_path|remote|$folder_uri"
                    end
                end
            end
        else
            if test "$debug_mode" = "true"
                echo "  Skipped (no folder_uri or is file_uri)"
            end
        end
        
        if test "$debug_mode" = "true"
            echo "  Current projects_list count: "(count $projects_list)
            echo ""
        end
    end

    if test (count $projects_list) -eq 0
        echo "No recent projects found"
        return 1
    end

    if test "$debug_mode" = "true"
        echo "Debug: Final projects list:"
        for project in $projects_list
            echo "  $project"
        end
        echo "Debug: Total projects found: "(count $projects_list)
        return 0
    end

    # Open floating kitty with fzf to select project
    # Create a temporary file to pass the projects list
    set -l projects_file (mktemp)
    printf '%s\n' $projects_list > "$projects_file"
    
    if test "$debug_mode" = "true"
        echo "Debug: Projects file created at: $projects_file"
        echo "Debug: Contents of projects file:"
        cat "$projects_file"
        echo "Debug: File line count: "(wc -l < "$projects_file")
        return 0
    end
    
    kitty --class=floating-selector --title="VS Code Recent Projects" fish -c "
        set -l projects_file '$projects_file'
        
        # Debug: Check if file exists and has content
        if not test -f \"\$projects_file\"
            echo \"Error: Projects file not found\"
            exit 1
        end
        
        # Create display list for fzf directly from the projects file
        set -l display_list
        while read -l project
            if test -n \"\$project\"
                set -l display (echo \"\$project\" | cut -d'|' -f1)
                set display_list \$display_list \"\$display\"
            end
        end < \"\$projects_file\"
        
        # Use printf to pass to fzf
        set selected (printf '%s\\n' \$display_list | fzf --prompt='Select Project: ' --height=50% --reverse --border --preview 'echo {}')
        
        if test -z \"\$selected\"
            rm \"\$projects_file\"
            exit 0
        end
        
        # Find the full path for the selected project
        set -l found_path
        set -l found_type
        while read -l project
            if test -n \"\$project\"
                set -l display (echo \"\$project\" | cut -d'|' -f1)
                set -l type (echo \"\$project\" | cut -d'|' -f2)
                set -l path (echo \"\$project\" | cut -d'|' -f3)
                if test \"\$display\" = \"\$selected\"
                    set found_path \"\$path\"
                    set found_type \"\$type\"
                    break
                end
            end
        end < \"\$projects_file\"
        
        if test -n \"\$found_path\"
            echo \"Opening \$selected in VS Code...\"
            if test \"\$found_type\" = \"local\"
                # Local project - use regular code command
                code \"\$found_path\"
            else
                # Remote project - use --folder-uri
                code --folder-uri \"\$found_path\"
            end
            
            if test \$status -eq 0
                echo \"Successfully opened \$selected in VS Code\"
                sleep 1
            else
                echo \"Failed to open in VS Code\"
                read -P 'Press Enter to continue...'
            end
        else
            echo \"Error: Project path not found\"
            read -P 'Press Enter to continue...'
        end
        
        rm \"\$projects_file\"
    "
end

