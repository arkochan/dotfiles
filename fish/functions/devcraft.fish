function git-feature-push --description 'start nvim from fzf selection'

    set use_current_branch 0
    set commit_msg ""
    set branch_name ""

    # Parse arguments
    for arg in $argv
        switch $arg
            case --current
                set use_current_branch 1
            case '*'
                if test -z "$branch_name"
                    set branch_name $arg
                else
                    set commit_msg "$commit_msg $arg"
                end
        end
    end

    # Trim whitespace from commit message
    set commit_msg (string trim "$commit_msg")

    # Validate input
    if test -z "$commit_msg"
        echo "Usage: git-feature-push [--current] <branch-name> <commit-message>"
        echo "  --current       Use current branch instead of creating a new one"
        echo "  <branch-name>   Name of new branch (ignored if --current is set)"
        echo "  <commit-message> Commit message in quotes"
        return 1
    end

    # Step 1: Create branch (if not using current)
    if test $use_current_branch -eq 0
        if test -z "$branch_name"
            echo "❌ Error: Branch name required if not using --current"
            return 1
        end
        git checkout -b $branch_name; or exit 1
    end

    # Step 2: Stage changes
    git add .; or exit 1

    # Step 3: Commit with message
    git commit -m "$commit_msg"; or exit 1

    # Step 4: Set timezone and amend commit
    set -x TZ America/Los_Angeles
    set timestamp (date "+%Y-%m-%dT%H:%M:%S %z"); or exit 1
    set -x GIT_AUTHOR_DATE $timestamp
    set -x GIT_COMMITTER_DATE $timestamp
    git commit --amend --no-edit --date="$timestamp"; or exit 1

    # Step 5: Show final commit for verification
    git log -1; or exit 1

    echo "✅ Commit completed. Please verify the above details before pushing."
end
