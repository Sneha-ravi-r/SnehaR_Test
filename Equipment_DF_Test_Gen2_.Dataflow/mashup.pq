section Section1;
shared Calibration_Category = let
  Source = PostgreSQL.Database("localhost", "gbs-trutesta-sandbox-prod"),
  #"Navigation 1" = Source{[Schema = "trutesta_equipment", Item = "calibration_category"]}[Data],
  #"Remove columns" = Table.RemoveColumns(#"Navigation 1", Table.ColumnsOfType(#"Navigation 1", {type table, type record, type list, type nullable binary, type binary, type function}))
in
  #"Remove columns";
shared Equipment = let
  Source = PostgreSQL.Database("localhost", "gbs-trutesta-sandbox-prod"),
  #"Navigation 1" = Source{[Schema = "trutesta_equipment", Item = "equipment"]}[Data],
  #"Remove columns" = Table.RemoveColumns(#"Navigation 1", Table.ColumnsOfType(#"Navigation 1", {type table, type record, type list, type nullable binary, type binary, type function}))
in
  #"Remove columns";
shared Maintenance_Schedule = let
  Source = PostgreSQL.Database("localhost", "gbs-trutesta-sandbox-prod"),
  #"Navigation 1" = Source{[Schema = "trutesta_equipment", Item = "maintenance_schedule"]}[Data],
  #"Remove columns" = Table.RemoveColumns(#"Navigation 1", Table.ColumnsOfType(#"Navigation 1", {type table, type record, type list, type nullable binary, type binary, type function}))
in
  #"Remove columns";
shared Service_Type = let
  Source = PostgreSQL.Database("localhost", "gbs-trutesta-sandbox-prod"),
  #"Navigation 1" = Source{[Schema = "trutesta_equipment", Item = "service_type"]}[Data],
  #"Remove columns" = Table.RemoveColumns(#"Navigation 1", Table.ColumnsOfType(#"Navigation 1", {type table, type record, type list, type nullable binary, type binary, type function}))
in
  #"Remove columns";
shared DBName = "gbs-trutesta-sandbox-prod" meta [IsParameterQuery = true, IsParameterQueryRequired = true, Type = type text, List = {"gbs-trutesta-sandbox", "gbs-trutesta-sandbox-prod", "gbs-trutesta-production"}, DefaultValue = "gbs-trutesta-sandbox-prod"];
shared DFVersion = "1.0.0" meta [IsParameterQuery = true, IsParameterQueryRequired = true, Type = type text];
shared #"DF Last Updated" = let
    Source = DateTimeZone.UtcNow(),
    #"Convert to table" = Table.FromValue(Source),
    #"Renamed columns" = Table.RenameColumns(#"Convert to table", {{"Value", "Updated Time in UTC"}})
in
    #"Renamed columns";
shared Calibration = let
    Source = PostgreSQL.Database(
        "localhost",
        DBName,
        [
            Query = "
            SELECT 
                ec.id,
                ec.tenant_id,
                ec.equipment_id,
                ec.calibration_date,
                ec.calibration_result,
                ec.date_created,
                ec.date_sent_for_calibration,
                ec.date_service_due,
                ec.date_service_completed,
                ec.date_service_canceled,
                ec.service_type_id,
                ec.service_result_id,
                ec.currency_iso_code,
                ec.service_fee,
                ec.status_code,
                ec.maintenance_schedule_id,
                ec.compliance_status
            FROM trutesta_equipment.equipment_calibration ec
            JOIN trutesta_equipment.equipment e 
                ON ec.equipment_id = e.id
            WHERE ec.service_type_id IS NOT NULL
              AND e.calibration_category_id IS NOT NULL
            ",
            CreateNavigationProperties = false
        ]
    )
in
    Source;
shared Department = let
  Source = PostgreSQL.Database("localhost", DBName, [Query = "SELECT id, name_text, site_id#(lf)from trutesta_equipment.equipment_location el#(lf)WHERE el.equipment_location_type_id#(lf)IN (SELECT DEPARTMENT_LOCATION_TYPE_ID FROM trutesta_equipment.equipment_policy where is_global_default = 1)", CreateNavigationProperties = false])
in
  Source;
shared Equipment_Calibration = let
  Source = PostgreSQL.Database("localhost", DBName, [Query = "SELECT#(lf)ec.id,#(lf)ec.tenant_id,#(lf)ec.equipment_id,#(lf)ec.calibration_date,#(lf)ec.calibration_result,#(lf)ec.date_created,#(lf)ec.date_sent_for_calibration,#(lf)ec.date_service_due,#(lf)ec.date_service_completed,#(lf)ec.date_service_canceled,#(lf)ec.service_type_id,#(lf)ec.service_result_id,#(lf)ec.currency_iso_code,#(lf)ec.service_fee,#(lf)ec.status_code,#(lf)ec.maintenance_schedule_id,#(lf)ec.compliance_status#(lf)FROM trutesta_equipment.equipment_calibration ec#(lf)JOIN trutesta_equipment.equipment e ON ec.equipment_id = e.id#(lf)WHERE ec.service_type_id IS NOT NULL#(lf)AND e.calibration_category_id IS NOT NULL;", CreateNavigationProperties = false])
in
  Source;
shared Checkout_Type = let
  Source = PostgreSQL.Database("localhost", "gbs-trutesta-sandbox-prod"),
  #"Navigation 1" = Source{[Schema = "trutesta_equipment", Item = "equipment_checkout_type"]}[Data],
  #"Remove columns" = Table.RemoveColumns(#"Navigation 1", Table.ColumnsOfType(#"Navigation 1", {type table, type record, type list, type nullable binary, type binary, type function}))
in
  #"Remove columns";
shared Equipment_Location = let
  Source = PostgreSQL.Database("localhost", "gbs-trutesta-sandbox-prod"),
  #"Navigation 1" = Source{[Schema = "trutesta_equipment", Item = "equipment_location"]}[Data],
  #"Remove columns" = Table.RemoveColumns(#"Navigation 1", Table.ColumnsOfType(#"Navigation 1", {type table, type record, type list, type nullable binary, type binary, type function}))
in
  #"Remove columns";
shared Checkout_Log = let
  Source = PostgreSQL.Database("localhost", "gbs-trutesta-sandbox-prod"),
  #"Navigation 1" = Source{[Schema = "trutesta_equipment", Item = "equipment_checkout_log"]}[Data],
  #"Remove columns" = Table.RemoveColumns(#"Navigation 1", Table.ColumnsOfType(#"Navigation 1", {type table, type record, type list, type nullable binary, type binary, type function}))
in
  #"Remove columns";
