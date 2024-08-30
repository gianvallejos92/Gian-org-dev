/**
 * Trigger Principal del Objeto OPORTUNIDAD. Es disparado al crear o modificar una Oportunidad.
 * @author Gian Vallejos
 * @since 1.0
 */
trigger OpportunityTriggerHandler on Opportunity (before insert, before update, after insert, after update) {
  if (Trigger.isAfter) {
    if (Trigger.isUpdate) {      
      OpportunityHandler.OnAfterUpdate(Trigger.New, Trigger.OldMap);
    }
  }
}