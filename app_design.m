classdef app_design < matlab.ui.componentcontainer.ComponentContainer

    % Properties that correspond to underlying components
    properties (Access = private, Transient, NonCopyable)
        GuessTheWordEditField  matlab.ui.control.EditField
        submitButton           matlab.ui.control.Button
        GuessthewordandclicksubmittoseeifitiscorrectLabel  matlab.ui.control.Label
        GridLayout             matlab.ui.container.GridLayout
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Callback function: not associated with a component
        function TextAreaValueChanged(comp, event)
            value = comp.TextArea.Value;
            
        end

        % Callback function: not associated with a component
        function TextAreaValueChanged2(comp, event)
            value = comp.TextArea.Value;
        end

        % Button pushed function: submitButton
        function submitButtonPushed(comp, event)
            disp 
        end
    end

    methods (Access = protected)
        
        % Code that executes when the value of a public property is changed
        function update(comp)
            % Use this function to update the underlying components
            
        end

        % Create the underlying components
        function setup(comp)

            comp.Position = [1 1 371 356];

            % Create GridLayout
            comp.GridLayout = uigridlayout(comp);
            comp.GridLayout.ColumnWidth = {'1x', '1x', '1x', '1x'};
            comp.GridLayout.RowHeight = {'1x', '1x', '1x', '1x', '1x'};

            % Create GuessthewordandclicksubmittoseeifitiscorrectLabel
            comp.GuessthewordandclicksubmittoseeifitiscorrectLabel = uilabel(comp);
            comp.GuessthewordandclicksubmittoseeifitiscorrectLabel.BackgroundColor = [1 1 1];
            comp.GuessthewordandclicksubmittoseeifitiscorrectLabel.HorizontalAlignment = 'center';
            comp.GuessthewordandclicksubmittoseeifitiscorrectLabel.VerticalAlignment = 'top';
            comp.GuessthewordandclicksubmittoseeifitiscorrectLabel.WordWrap = 'on';
            comp.GuessthewordandclicksubmittoseeifitiscorrectLabel.FontSize = 14;
            comp.GuessthewordandclicksubmittoseeifitiscorrectLabel.FontWeight = 'bold';
            comp.GuessthewordandclicksubmittoseeifitiscorrectLabel.Position = [-194 198 179 159];
            comp.GuessthewordandclicksubmittoseeifitiscorrectLabel.Text = 'Guess the word and click submit to see if it is correct!';

            % Create GuessTheWordEditField
            comp.GuessTheWordEditField = uieditfield(comp, 'text');
            comp.GuessTheWordEditField.FontSize = 14;
            comp.GuessTheWordEditField.Position = [-161 262 114 31];

            % Create submitButton
            comp.submitButton = uibutton(comp, 'push');
            comp.submitButton.ButtonPushedFcn = matlab.apps.createCallbackFcn(comp, @submitButtonPushed, true);
            comp.submitButton.BackgroundColor = [0 1 1];
            comp.submitButton.Position = [-146 226 89 26];
            comp.submitButton.Text = 'submit';
        end
    end
end