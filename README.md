Script to manually measure the height of sediment in digital time-lapse photos of a sediment trap

Modified from Daniel Buscombe's 2009 Cobble Cam digital pebble count script by Liam Horner (WWU), 2020

------------------------------------------------------------------------
Instructions

1. Take all the photos that you want to process, put them in a single folder, and save it to your working directory with the SedTrapMeasurmentTool script
2. Run the SedTrapMeasurementTool script
3. This will prompt you to select the folder containing the photos that you want to process
4. A window will prompt you to enter the mm/pixel conversion factor for your images. If you know what the conversion factor is, enter it and skip to step 10
5. If you don't know the conversion factor, enter 0 and proceed to the next step to extract the mm/pixel comversion from a scale in your imagery
6. A window will open with the first trap image
7. Draw a box with the cursor to zoom-in on the ruler/scale
8. This will prompt you to specify the distance you will measure on the ruler to calculate the mm/pixel conversion factor (default is 150 mm)
9. Using the cursor, select 2 points to draw a line of the specified length
10. A maximized window with the first trap image will now open
11. Indicate in the dialouge box whether the image is clear enough to measure the sediment height (if 'yes' proceed to next step, if 'no' skip to step 13)
12. Using the cursor, click on the bottom and top of the sediment column in the trap to measure how high the sediment is
13. Repeat step 11 for the rest of the images as each image is displayed
14. When you have completed all the images, an Excel file will be generated with the measured sediment height in each image (in mm and in pixels)
15. Manually enter the GPS coordinates of the trap location in the Excel file, if you wish
16. Rename the Excel file with a unique name, so that it doesn't get overwritten the next time you use the SedTrapMeasurementTool script
