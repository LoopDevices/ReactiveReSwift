//
//  MiddlewareFakes.swift
//  ReSwiftRx
//
//  Created by Charlotte Tortorella on 25/11/16.
//  Copyright © 2016 Benjamin Encz. All rights reserved.
//

import ReSwiftRx

let firstMiddleware = Middleware<TestStringAppState> { state, dispatch, action in
    if let action = action as? SetValueStringAction {
        return SetValueStringAction(action.value + " First Middleware")
    }
    return action
}

let secondMiddleware = Middleware<TestStringAppState> { state, dispatch, action in
    if let action = action as? SetValueStringAction {
        return SetValueStringAction(action.value + " Second Middleware")
    }
    return action
}

let dispatchingMiddleware = Middleware<TestStringAppState> { state, dispatch, action in
    if let action = action as? SetValueAction {
        dispatch(SetValueStringAction("\(action.value)"))
        return NoOpAction()
    }
    return action
}

let stateAccessingMiddleware = Middleware<TestStringAppState> { state, dispatch, action in
    if let action = action as? SetValueStringAction {
        if state.testValue == "OK" && action.value != "Not OK" {
            dispatch(SetValueStringAction("Not OK"))
            return NoOpAction()
        }
    }
    return action
}
