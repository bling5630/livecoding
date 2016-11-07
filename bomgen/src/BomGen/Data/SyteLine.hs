module BomGen.Data.SyteLine where

import BasicPrelude

import BomGen.Data.Bom

data SytelineItem = SytelineItem
    { sliItem   :: !Text -- "Item"
    , sliUoM    :: !UnitOfMeasure -- "U/M"
    , sliDesc   :: !Text -- "Description"
    , sliCol003 :: !Text -- "Quantity On Hand"
    , sliCol004 :: !Text -- "Safety Stock"
    , sliCol005 :: !Text -- "Type,Standard Unit Cost"
    , sliCol006 :: !Text -- "Current Unit Cost"
    , sliCol007 :: !Text -- "Stocked"
    , sliCol008 :: !Text -- "Source"
    , sliCol009 :: !Text -- "Planner Code"
    , sliCol010 :: !Text -- "Buyer"
    , sliCol011 :: !Text -- "Product Code"
    , sliCol012 :: !Text -- "ABC Code"
    , sliCol013 :: !Text -- "Cost Type"
    , sliCol014 :: !Text -- "Cost Method"
    , sliCol015 :: !Text -- "Revision"
    , sliCol016 :: !Text -- "Revision Track"
    , sliCol017 :: !Text -- "ECN"
    , sliCol018 :: !Text -- "Drawing Number"
    , sliCol019 :: !Text -- "Alternate Item"
    , sliCol020 :: !Text -- "Show In Drop-Down Lists"
    , sliCol021 :: !Text -- "Created By"
    , sliCol022 :: !Text -- "Create Date"
    , sliCol023 :: !Text -- "Lot Size"
    , sliCol024 :: !Text -- "Unit Weight"
    , sliCol025 :: !Text -- "Weight Units"
    , sliCol026 :: !Text -- "Non-Nettable Stock"
    , sliCol027 :: !Text -- "Quantity Ordered"
    , sliCol028 :: !Text -- "Quantity WIP"
    , sliCol029 :: !Text -- "Allocated To Prod"
    , sliCol030 :: !Text -- "Allocated To Customer Orders"
    , sliCol031 :: !Text -- "Reserved For Customer Orders"
    , sliCol032 :: !Text -- "Low Level"
    , sliCol033 :: !Text -- "Active for Data Integration"
    , sliCol034 :: !Text -- "Shrink Factor"
    , sliCol035 :: !Text -- "Phantom Flag"
    , sliCol036 :: !Text -- "MPS Flag"
    , sliCol037 :: !Text -- "Net Change"
    , sliCol038 :: !Text -- "MPS Plan Fence"
    , sliCol039 :: !Text -- "Family Code"
    , sliCol040 :: !Text -- "Production Type"
    , sliCol041 :: !Text -- "Rate/Day"
    , sliCol042 :: !Text -- "Inventory LCL %"
    , sliCol043 :: !Text -- "Inventory UCL %"
    , sliCol044 :: !Text -- "Supply Site"
    , sliCol045 :: !Text -- "Supply Whse"
    , sliCol046 :: !Text -- "Paper Work"
    , sliCol047 :: !Text -- "Fixed Lead Time"
    , sliCol048 :: !Text -- "Expedited Fixed"
    , sliCol049 :: !Text -- "Dock-to-Stock"
    , sliCol050 :: !Text -- "Variable"
    , sliCol051 :: !Text -- "Expedited Variable"
    , sliCol052 :: !Text -- "Separation"
    , sliCol053 :: !Text -- "Release 1"
    , sliCol054 :: !Text -- "Release 2"
    , sliCol055 :: !Text -- "Release 3"
    , sliCol056 :: !Text -- "MRP Item"
    , sliCol057 :: !Text -- "Infinite"
    , sliCol058 :: !Text -- "Planned Mfg Supply Switching"
    , sliCol059 :: !Text -- "Accept Requirements"
    , sliCol060 :: !Text -- "Pass Requirements"
    , sliCol061 :: !Text -- "Must use future POs before creating PLNs"
    , sliCol062 :: !Text -- "Supply Usage Tolerance"
    , sliCol063 :: !Text -- "Time Fence Rule"
    , sliCol064 :: !Text -- "Time Fence Value"
    , sliCol065 :: !Text -- "Setup Group"
    , sliCol066 :: !Text -- "Order Minimum"
    , sliCol067 :: !Text -- "Order Multiple"
    , sliCol068 :: !Text -- "Order Maximum"
    , sliCol069 :: !Text -- "Days Supply"
    , sliCol070 :: !Text -- "Use Reorder Point"
    , sliCol071 :: !Text -- "Reorder Point"
    , sliCol072 :: !Text -- "Fixed Order Qty"
    , sliCol073 :: !Text -- "Earliest Planned Purchase Receipt"
    , sliCol074 :: !Text -- "Targeted Safety Stock Replenishment"
    , sliCol075 :: !Text -- "Lot Track"
    , sliCol076 :: !Text -- "Preassign Lots"
    , sliCol077 :: !Text -- "Lot Prefix"
    , sliCol078 :: !Text -- "S/N Track"
    , sliCol079 :: !Text -- "Preassign Serials"
    , sliCol080 :: !Text -- "S/N Prefix"
    , sliCol081 :: !Text -- "Shelf Life"
    , sliCol082 :: !Text -- "Issue By"
    , sliCol083 :: !Text -- "Material Status"
    , sliCol084 :: !Text -- "Reason"
    , sliCol085 :: !Text -- "Last Change"
    , sliCol086 :: !Text -- "User"
    , sliCol087 :: !Text -- "Backflush"
    , sliCol088 :: !Text -- "Backflush Location"
    , sliCol089 :: !Text -- "Preferred Co-product Mix"
    , sliCol090 :: !Text -- "Reservable"
    , sliCol091 :: !Text -- "Tax-Free Imported Material"
    , sliCol092 :: !Text -- "Tax Free Days"
    , sliCol093 :: !Text -- "Safety Stock Percent"
    , sliCol094 :: !Text -- "Tariff Classification"
    , sliCol095 :: !Text -- "PO Tolerance Over"
    , sliCol096 :: !Text -- "PO Tolerance Under"
    , sliCol097 :: !Text -- "Kit"
    , sliCol098 :: !Text -- "Print Kit Components on Customer Paperwork"
    , sliCol099 :: !Text -- "Std Due Period"
    , sliCol100 :: !Text -- "Commodity"
    , sliCol101 :: !Text -- "Commodity Description"
    , sliCol102 :: !Text -- "Taxable"
    , sliCol103 :: !Text -- "Tax Code Description"
    , sliCol104 :: !Text -- "Origin"
    , sliCol105 :: !Text -- "Country"
    , sliCol106 :: !Text -- "Preference Criterion"
    , sliCol107 :: !Text -- "Country Of Origin"
    , sliCol108 :: !Text -- "Producer"
    , sliCol109 :: !Text -- "Subject To RVC Requirements"
    , sliCol110 :: !Text -- "Purchased YTD"
    , sliCol111 :: !Text -- "Manufactured YTD"
    , sliCol112 :: !Text -- "Used YTD"
    , sliCol113 :: !Text -- "Sold YTD"
    , sliCol114 :: !Text -- "Subject To Excise Tax"
    , sliCol115 :: !Text -- "Excise Tax Percent"
    , sliCol116 :: !Text -- "Wholesale Price"
    , sliCol117 :: !Text -- "Includes Item Content"
    , sliCol118 :: !Text -- "Order Configurable"
    , sliCol119 :: !Text -- "Job Configurable"
    , sliCol120 :: !Text -- "Auto Job Generation"
    , sliCol121 :: !Text -- "Name Space"
    , sliCol122 :: !Text -- "Configuration Flag"
    , sliCol123 :: !Text -- "Feature String"
    , sliCol124 :: !Text -- "Feature Template"
    , sliCol125 :: !Text -- "Last Import Date"
    , sliCol126 :: !Text -- "Save Current Revision Upon Import"
    , sliCol127 :: !Text -- "Overview"
    , sliCol128 :: !Text -- "Active For Customer Portal"
    , sliCol129 :: !Text -- "Featured Item"
    , sliCol130 :: !Text -- "Top Seller"
    , sliCol131 :: !Text -- "Item Attribute Group"
    , sliCol132 :: !Text -- "Item Attribute Group Description"
    , sliCol133 :: !Text -- "Lot Attribute Group"
    , sliCol134 :: !Text -- "Lot Attribute Group Description"
    , sliCol135 :: !Text -- "Enable Pieces Inventory"
    , sliCol136 :: !Text -- "Piece Dimension Group"
    , sliCol137 :: !Text -- "Piece Dimension Group Description"
    , sliCol138 :: !Text -- "Portal Pricing Enabled"
    , sliCol139 :: !Text -- "Portal Pricing Site"
    , sliCol140 :: !Text -- "Freight"
    , sliCol141 :: !Text -- "Estimated Break Date"
    , sliCol142 :: !Text -- "Date of Last Report"
    } deriving (Show, Eq)


data SytelineMaterial = SytelineMaterial
    { slmCol000 :: !Text -- Item
    , slmCol001 :: !Text -- Item Description
    , slmCol002 :: !Text -- Operation
    , slmCol003 :: !Text -- WC
    , slmCol004 :: !Text -- Material
    , slmCol005 :: !Text -- Material Description
    , slmCol006 :: !Text -- Quantity
    , slmCol007 :: !Text -- U/M
    , slmCol008 :: !Text -- Scrap Factor
    , slmCol009 :: !Text -- Backflush
    , slmCol010 :: !Text -- Backflush Location
    , slmCol011 :: !Text -- Per
    , slmCol012 :: !Text -- Alt Group
    , slmCol013 :: !Text -- Alt Group Rank
    , slmCol014 :: !Text -- Cost
    , slmCol015 :: !Text -- Ref
    , slmCol016 :: !Text -- Material Cost
    , slmCol017 :: !Text -- Labor Cost
    , slmCol018 :: !Text -- Outside Cost
    , slmCol019 :: !Text -- Fixed Overhead Cost
    , slmCol020 :: !Text -- Variable Overhead Cost
    , slmCol021 :: !Text -- Effect Date
    , slmCol022 :: !Text -- Obsolete Date
    , slmCol023 :: !Text -- Type
    , slmCol024 :: !Text -- Seq
    , slmCol025 :: !Text -- Manufacturer
    , slmCol026 :: !Text -- Manufacturer Name
    , slmCol027 :: !Text -- Manufacturer Item
    , slmCol028 :: !Text -- Manufacturer Item Description
    , slmCol029 :: !Text -- BOM Seq
    , slmCol030 :: !Text -- Feature
    , slmCol031 :: !Text -- Option Code
    , slmCol032 :: !Text -- Probable
    , slmCol033 :: !Text -- Incremental Price
    , slmCol034 :: !Text -- Estimated Break Date
    , slmCol035 :: !Text -- Date of Last Report
    , slmCol036 :: !Text -- Fixed Material
    , slmCol037 :: !Text -- Variable Material
    , slmCol038 :: !Text -- WC Description
    } deriving (Eq, Show)


data SytelineOperation = SytelineOperation
    { sloCol000 :: !Text -- "Item"
    , sloCol001 :: !Text -- "Item Description"
    , sloCol002 :: !Text -- "Operation"
    , sloCol003 :: !Text -- "WC"
    , sloCol004 :: !Text -- "WC Description"
    , sloCol005 :: !Text -- "Use Fixed Schedule"
    , sloCol006 :: !Text -- "Fixed Sched Hours"
    , sloCol007 :: !Text -- "Run-Hours Basis (Machine)"
    , sloCol008 :: !Text -- "Mach Hrs per Piece,Run-Hours Basis (Labor)"
    , sloCol009 :: !Text -- "Labor Hr per Piece"
    , sloCol010 :: !Text -- "Sched Driver"
    , sloCol011 :: !Text -- "Run Duration"
    , sloCol012 :: !Text -- "Batch Definition"
    , sloCol013 :: !Text -- "Yield"
    , sloCol014 :: !Text -- "Move Hours"
    , sloCol015 :: !Text -- "Queue Time"
    , sloCol016 :: !Text -- "Setup Hours"
    , sloCol017 :: !Text -- "Finish"
    , sloCol018 :: !Text -- "Use Offset Hours"
    , sloCol019 :: !Text -- "Offset Hours"
    , sloCol020 :: !Text -- "Effective Date"
    , sloCol021 :: !Text -- "Obsolete Date"
    , sloCol022 :: !Text -- "Control Point"
    , sloCol023 :: !Text -- "Backflush"
    , sloCol024 :: !Text -- "Setup Resource Group"
    , sloCol025 :: !Text -- "Setup Rule"
    , sloCol026 :: !Text -- "Setup Basis"
    , sloCol027 :: !Text -- "Setup Time Rule"
    , sloCol028 :: !Text -- "Setup Matrix"
    , sloCol029 :: !Text -- "Scheduler Rule"
    , sloCol030 :: !Text -- "Split Size"
    , sloCol031 :: !Text -- "Custom Planner Rule"
    , sloCol032 :: !Text -- "Break Rule"
    , sloCol033 :: !Text -- "Efficiency"
    , sloCol034 :: !Text -- "Setup Rate"
    , sloCol035 :: !Text -- "Run Rate (Labor)"
    , sloCol036 :: !Text -- "Var Mach Ovhd Rate"
    , sloCol037 :: !Text -- "Fix Machine Ovhd Rate"
    , sloCol038 :: !Text -- "Var Ovhd Rate"
    , sloCol039 :: !Text -- "Fixed Ovhd Rate"
    } deriving (Eq, Show)
