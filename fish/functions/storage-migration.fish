function storage-migration -d "Cloning assistance when replacing storage devices with dd"
    dependencies dd ddrescue || return 1

    # Confirmation
    authenticator root || return 1
    confirmation dd ddrescue || return 1

    # Operation
    # Validation
end
