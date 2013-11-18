module MessagesHelper
    def find_status(f)
        if f.deleted == true
            return "Deleted"
        elsif f.read == true
            return "Read"
        else
            return "Unread"
        end
    end
end
