import {
	defaultLevel as baseDefaultLevel,
	Logger as BaseLogger,
	logLevels as baseLogLevels,
	logTypes as baseLogTypes,
} from "./class/base-logger.js"

export const logTypes = baseLogTypes

export const logLevels = baseLogLevels

export const defaultLevel = baseDefaultLevel

export const Logger = BaseLogger

export default Logger
