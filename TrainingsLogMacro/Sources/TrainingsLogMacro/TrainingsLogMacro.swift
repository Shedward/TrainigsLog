
@attached(member, names: arbitrary)
public macro ModelData() = #externalMacro(
    module: "TrainingsLogMacroMacros",
    type: "ModelDataMacro"
)
