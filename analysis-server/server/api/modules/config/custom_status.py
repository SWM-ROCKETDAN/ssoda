class Success:
    JOIN_POST_UPDATE_OK = {
        "message": "JOIN_POST_UPDATE",
        "status": 201,
        "code": "SUCCESS_001"
    }

    JOIN_USER_UPDATE_OK = {
        "message": "JOIN_USER_UPDATE",
        "status": 201,
        "code": "SUCCESS_002"
    }


class ClientError:
    JOIN_FOUND_ERROR = {
        "message": "JOIN_POST_FOUND_ERROR",
        "status": 404,
        "code": "CLIENT_ERROR_001"
    }

    JOIN_POST_FOUND_ERROR = {
        "message": "JOIN_POST_FOUND_ERROR",
        "status": 404,
        "code": "CLIENT_ERROR_002"
    }

    JOIN_USER_FOUND_ERROR = {
        "message": "JOIN_USER_FOUND_ERROR",
        "status": 404,
        "code": "CLIENT_ERROR_003"
    }

    EVENT_FOUND_ERROR = {
        "message": "EVENT_FOUND_ERROR",
        "status": 404,
        "code": "CLIENT_ERROR_004"
    }


class ServerError:
    JOIN_POST_UPDATE_ERROR = {
        "message": "JOIN_POST_UPDATE_ERROR",
        "status": 506,
        "code": "SERVER_ERROR_001"
    }

    JOIN_USER_UPDATE_ERROR = {
        "message": "JOIN_USER_UPDATE_ERROR",
        "status": 506,
        "code": "SERVER_ERROR_002"
    }

    JOIN_CRAWL_POST_ERROR = {
        "message": "JOIN_CRAWL_POST_ERROR",
        "status": 506,
        "code": "SERVER_ERROR_003"
    }

    JOIN_CRAWL_USER_ERROR = {
        "message": "JOIN_CRAWL_USER_ERROR",
        "status": 506,
        "code": "SERVER_ERROR_004"
    }

    JOIN_REWARD_ERROR = {
        "message": "JOIN_REWARD_ERROR",
        "status": 506,
        "code": "SERVER_ERROR_005"
    }

    REPORT_ERROR = {
        "message": "REPORT_ERROR",
        "status": 506,
        "code": "SERVER_ERROR_006"
    }

